class ComicsController < ApplicationController
  def index
    comics = Comic.order(sold_at: :desc)
    comics = comics.joins(:characters).where('characters.name LIKE ?', "%#{params[:search]}%") if params[:search].present?

    @comics = comics.page(params[:page] || 1).per(15)
  end

  def favourite_comic
    comic = Comic.find_by(comic_id: comic_params[:comic_id])
    raise 'Comic not found' if comic.nil?

    if favourite_comic = current_user.favourites.find_by(comic_id: comic.id)
      favourite_comic.destroy
      message = 'favourite removed'
    else
      current_user.comics << comic
      message = 'favourite added'
    end

    render json: { message: message }, status: :ok
  rescue StandardError => e
    render json: { message: e }, status: :bad_request
  end

  def comic_params
    params.require(:comic).permit(:comic_id)
  end
end
