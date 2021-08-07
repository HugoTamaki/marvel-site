require 'rails_helper'

describe Character, type: :model do
  describe 'validations' do
    it 'is not valid without fields' do
      character = Character.new
      expect(character).not_to be_valid
    end

    it 'is valid with all fields' do
      character = Character.new(name: 'Hulk')
      expect(character).to be_valid
    end
  end
end
