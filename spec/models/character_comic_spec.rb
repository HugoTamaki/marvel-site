require 'rails_helper'

describe CharacterComic, type: :model do
  let!(:comic) { FactoryBot.create(:comic) }
  let!(:character) { FactoryBot.create(:character) }

  describe 'validations' do
    it 'does not allows relation of same character for same comic twice' do
      comic.characters << character
      expect(comic.characters.count).to eql(1)

      expect { comic.characters << character }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
