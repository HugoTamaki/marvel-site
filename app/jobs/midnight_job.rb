class MidnightJob < ApplicationJob
  queue_as :default

  def perform(*args)
    MarvelApiService.update_comics
    UserManagementService.clean_expired_users
  end
end
