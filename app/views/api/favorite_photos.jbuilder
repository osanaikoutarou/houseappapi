json.favorite_photos do

	json.array!(@favoritePhotos) do |favoritePhoto|
		json.favorite_photo favoritePhoto
	end

end