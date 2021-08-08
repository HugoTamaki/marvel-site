require 'rails_helper'

describe Favourite, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:comic) { FactoryBot.create(:comic) }

  describe 'validations' do
    it 'does not allows relation of same character for same comic twice' do
      user.comics << comic
      expect(user.comics.count).to eql(1)

      expect { user.comics << comic }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
