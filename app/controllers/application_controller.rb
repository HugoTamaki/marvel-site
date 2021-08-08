class ApplicationController < ActionController::Base

  before_action :set_user

  private

  def set_user
    return if cookies[:user_cookie_hash].present?

    cookies[:user_cookie_hash] = { value: SecureRandom.hex(5), expires: 30.minutes }
    User.create(cookie_hash: cookies[:user_cookie_hash], expires_at: Time.now + 30.minutes)
  end

  def current_user
    User.find_by(cookie_hash: cookies[:user_cookie_hash])
  end
end
