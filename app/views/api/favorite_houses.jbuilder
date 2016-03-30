json.favorite_houses do

	json.array!(@favoriteHouses) do |house|
		json.house house
	end
end
