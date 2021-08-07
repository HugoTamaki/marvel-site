class MidnightJob < ApplicationJob
  queue_as :default

  def perform(*args)
    MarvelApiService.update_comics
  end
end
