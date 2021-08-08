require 'rails_helper'

describe 'Application', :type => :request do
  before do
    Timecop.freeze(Time.now)
  end

  describe 'user management' do
    it 'creates user with securerandom hash' do
      expect(User.count).to eql(0)
      get '/'
      expect(User.count).to eql(1)
    end

    it 'renew user each 30 minutes' do
      get '/'
      expect(User.count).to eql(1)
      new_time = Time.now + 30.minutes
      Timecop.travel(new_time)
      get '/'
      expect(User.count).to eql(2)
      first_user = User.first
      second_user = User.last
      expect(first_user.cookie_hash).not_to match(second_user.cookie_hash)
    end
  end

  before do
    Timecop.return
  end
end
