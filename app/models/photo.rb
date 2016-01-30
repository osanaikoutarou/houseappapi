class Photo < ActiveRecord::Base
	belongs_to :house
<<<<<<< HEAD
=======
	has_many :favorite_photo
>>>>>>> parent of 34fb912... gitignore
	has_many :favorite_photos
end
