class Comic < ApplicationRecord
  validates :comic_id, :title, :comic_url, presence: true

  has_many :character_comics, dependent: :destroy
  has_many :characters, through: :character_comics
end
