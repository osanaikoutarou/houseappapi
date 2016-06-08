json.favorite_houses do

	json.array!(@favoriteHouses) do |house|
		json.house house
		json.photos house.photos
		json.architect house.architect
	end
end
