namespace :routines do
  desc "Imports comics from Marvel API"
  task import_comics: :environment do
    MarvelApiService.update_comics
  end

  desc "Clean expired users"
  task clean_users: :environment do
    UserManagementService.clean_expired_users
  end
end
