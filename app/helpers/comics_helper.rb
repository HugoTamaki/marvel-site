module ComicsHelper
  def set_favourite_image_by_user(user, comic_id)
    favourite_comic = user.comics.find_by(comic_id: comic_id)
    return 'heart_on.png' if favourite_comic.present?

    'heart_off.png'
  end

  def current_user
    User.find_by(cookie_hash: cookies[:user_cookie_hash])
  end
end
