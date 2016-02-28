json.favorite_photos do

	json.array!(@favoritePhotos) do |photo|
		json.photo photo
	end
end