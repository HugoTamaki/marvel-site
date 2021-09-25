class MidnightJob < ApplicationJob
  queue_as :default

  def perform(*args)
    date = Comic.maximum('modified_at')&.strftime('%Y-%m-%d')
    MarvelApiService.update_comics(date)
    UserManagementService.clean_expired_users
  end
end
