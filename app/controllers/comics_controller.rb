class ComicsController < ApplicationController
  def index
    comics = Comic.distinct.order(sold_at: :desc)
    comics = comics.joins(:characters).where('LOWER(characters.name) LIKE ?', "%#{params[:search].downcase}%") if params[:search].present?

    @comics = comics.page(params[:page] || 1).per(15)
  end

  def favourite_comic
    comic = Comic.find_by(comic_id: comic_params[:comic_id])
    render json: { message: 'Comic not found' }, status: :not_found and return if comic.nil?

    if favourite_comic = current_user.favourites.find_by(comic_id: comic.id)
      favourite_comic.destroy
      message = 'favourite removed'
    else
      current_user.comics << comic
      message = 'favourite added'
    end

    render json: { message: message }, status: :ok
  end

  def comic_params
    params.require(:comic).permit(:comic_id)
  end
end
