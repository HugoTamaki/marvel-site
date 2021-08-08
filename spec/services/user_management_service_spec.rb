require 'rails_helper'

describe UserManagementService do

  let!(:expired_user) { FactoryBot.create(:user, cookie_hash: 'abcd', expires_at: Time.now - 40.minutes) }
  let!(:active_user) { FactoryBot.create(:user, cookie_hash: 'efgh', expires_at: Time.now + 30.minutes) }

  describe '.clean_expired_users' do

    it 'cleans expired users' do
      expect(User.count).to eql(2)
      UserManagementService.clean_expired_users

      expect(User.count).to eql(1)
      expect(User.find_by(cookie_hash: expired_user.cookie_hash)).to be_nil
      expect(User.find_by(cookie_hash: active_user.cookie_hash)).to eql(active_user)
    end
  end

end
