require 'rails_helper'

describe MidnightJob, type: :job do
  before do
    allow(MarvelApiService).to receive(:update_comics).and_return(true)
    allow(UserManagementService).to receive(:clean_expired_users).and_return(true)
  end

  it 'calls MarvelApiService' do
    expect(MarvelApiService).to receive(:update_comics)
    MidnightJob.perform_now
  end

  it 'calls UserManagementService' do
    expect(UserManagementService).to receive(:clean_expired_users)
    MidnightJob.perform_now
  end
end
