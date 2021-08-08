class UserManagementService
  class << self
    def clean_expired_users
      users_to_remove = User.where('expires_at < ?', Time.now)
      users_to_remove.destroy_all
    end
  end
end
