require 'rails_helper'

describe Comic, type: :model do
  describe 'validations' do
    it 'is not valid without fields' do
      comic = Comic.new
      expect(comic).not_to be_valid
    end

    it 'is valid with all fields' do
      comic = Comic.new(comic_id: '1234',title: 'title', comic_url: 'http://comic.com.br')
      expect(comic).to be_valid
    end
  end
end
