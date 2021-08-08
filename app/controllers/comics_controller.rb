class ComicsController < ApplicationController
  def index
    comics = Comic.order(sold_at: :desc)
    comics = comics.joins(:characters).where('characters.name LIKE ?', "%#{params[:search]}%") if params[:search].present?

    @comics = comics.page(params[:page] || 1).per(15)
  end

  def favourite_comic
    comic = Comic.find_by(comic_id: params[:comic_id])
    raise 'Comic not found' if comic.nil?

    if favourite_comic = current_user.favourites.find_by(comic_id: comic.id)
      favourite_comic.destroy
    else
      current_user.comics << comic
    end

    render json: { message: 'Ok' }, status: :ok
  rescue StandardError => e
    render json: { message: e }, status: :bad_request
  end
end
