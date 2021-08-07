class MarvelApiService
  INFINITY = 1.0/0
  OFFSET_NUMBER = 100

  class << self
    def update_comics
      CharacterComic
      @total = INFINITY
      offset = 0
      comics_count = OFFSET_NUMBER
      while comics_count <= @total
        fetch_comics(offset).each do |comic_hash|
          comic = Comic.find_or_initialize_by(comic_id: comic_hash.dig('id'))
          comic.title = comic_hash.dig('title')
          comic.description = comic_hash.dig('description')
          comic.comic_url = comic_hash.dig('urls')&.first&.dig('url')
          comic.thumbnail = image_path(comic_hash.dig('thumbnail'))
          comic.sold_at = sold_at_date(comic_hash)
          comic.save if comic.new_record? || comic.changed?

          characters = comic_hash.dig('characters', 'items') || []
          characters.each do |character_hash|
            character = Character.find_or_initialize_by(name: character_hash.dig('name'))
            character.save if character.new_record?
            comic.characters << character unless comic.characters.any? { |c| c.name == character.name }
          end
        end

        if comics_count > (@total / OFFSET_NUMBER) * OFFSET_NUMBER
          offset += @total % OFFSET_NUMBER
          comics_count += @total % OFFSET_NUMBER
        else
          offset += OFFSET_NUMBER
          comics_count += OFFSET_NUMBER
        end
      end
    rescue JSON::ParserError
      { error: 'JSON parse error' }
    end

    def fetch_comics(offset = 0)
      response = Net::HTTP.get(URI.parse(self.url(offset)))
      parsed_response = JSON.parse(response || '{}')
      @total = parsed_response&.dig('data', 'total')
      parsed_response&.dig('data', 'results')
    end

    def url(offset = 0, limit = 100)
      "#{ENV['MARVEL_API_URL']}/comics?offset=#{offset}&limit=#{limit}#{api_credentials}"
    end

    def image_path(hash)
      "#{hash.dig('path')}.#{hash.dig('extension')}"
    end

    def sold_at_date(hash)
      date = (hash.dig('dates') || []).find { |date| date.dig('type') == 'onsaleDate' }&.dig('date')
      return nil if date.nil?

      DateTime.parse(date)
    rescue
      nil
    end

    def api_credentials
      timestamp = Time.now.to_i
      public_api_key = ENV['MARVEL_PUBLIC_KEY']
      private_api_key = ENV['MARVEL_PRIVATE_KEY']
      hash = Digest::MD5.hexdigest("#{timestamp}#{private_api_key}#{public_api_key}")
      "&apikey=#{public_api_key}&ts=#{timestamp}&hash=#{hash}"
    end
  end
end
