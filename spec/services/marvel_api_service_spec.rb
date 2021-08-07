require 'rails_helper'

describe MarvelApiService do
  before do
    Timecop.freeze(Time.local(2021, 8, 7, 9, 5, 0))
  end

  describe '.api_credentials' do

    it 'generates api credencials for url' do
      timestamp = Time.now.to_i
      expect(MarvelApiService.api_credentials).to eql("&apikey=abcd&ts=1628337900&hash=e2e4d69c10436a7cc7183b90fcda9da7")
    end
  end

  describe '.image_path' do
    it 'mounts url with extension' do
      image_path = MarvelApiService.image_path({'path' => 'http://test.com/image', 'extension' => 'jpg'})
      expect(image_path).to eql('http://test.com/image.jpg')
    end
  end

  describe '.fetch_comics' do
    it 'gets comics results from marvel api service' do
      VCR.use_cassette('successfull_marvel_api_get') do
        result = MarvelApiService.fetch_comics
        expect(result.count).to eql(100)
      end
    end
  end

  describe '.update_comics' do

    it 'creates comics from marvel api service' do
      VCR.use_cassette('successfull_marvel_api_get') do
        result = MarvelApiService.update_comics
        expect(Comic.count).to eql(100)
        expect(Character.count).to eql(57)
      end
    end

  end

  after do
    Timecop.return
  end
end
