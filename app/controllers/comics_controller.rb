class ComicsController < ApplicationController
  def index
    comics = Comic.order(sold_at: :desc)
    comics = comics.joins(:characters).where('characters.name LIKE ?', "%#{params[:search]}%") if params[:search].present?

    @comics = comics.page(params[:page] || 1).per(15)
  end
end
