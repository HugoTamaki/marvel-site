class CharacterComic < ApplicationRecord
  belongs_to :comic
  belongs_to :character

  validates_uniqueness_of :comic_id, scope: :character_id
end
