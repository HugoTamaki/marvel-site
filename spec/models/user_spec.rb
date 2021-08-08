require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    it 'is not valid without fields' do
      user = User.new
      expect(user).not_to be_valid
    end

    it 'is valid with all fields' do
      user = User.new(cookie_hash: SecureRandom.hex(5))
      expect(user).to be_valid
    end
  end
end
