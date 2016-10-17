class Photo < ActiveRecord::Base
	belongs_to :house
	belongs_to :architect
	has_many :favorite_photos
end
