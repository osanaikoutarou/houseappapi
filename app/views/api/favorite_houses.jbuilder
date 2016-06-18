json.favorite_houses do

	json.array!(@favoriteHouses) do |favorite_house|
		json.favorite_house favorite_house
		json.photos favorite_house.photos
		json.architect favorite_house.architect
	end
end
