class Character < ApplicationRecord
	validates :name, presence: true

	has_many :comics, through: :character_comics
end
