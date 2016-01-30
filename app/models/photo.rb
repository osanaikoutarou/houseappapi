class Photo < ActiveRecord::Base
	belongs_to :house
	has_many :favorite_photo
	has_many :favorite_photos
end
