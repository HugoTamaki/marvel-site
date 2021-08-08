class User < ApplicationRecord
  validates :cookie_hash, presence: true

  has_many :favourites
  has_many :comics, through: :favourites
end
