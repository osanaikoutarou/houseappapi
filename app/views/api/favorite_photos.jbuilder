json.favorite_photos do

	json.array!(@favoritePhotos) do |favoritePhoto|
		json.favorite_photo favoritePhoto
		json.photo favoritePhoto.photo
		json.house favoritePhoto.photo.house
		json.architect favoritePhoto.photo.house.architect
	end

end