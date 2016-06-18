json.favorite_houses do
	json.array!(@favoriteHouses) do |favoriteHouse|
		json.favorite_house favoriteHouse
		json.architect favoriteHouse.architect
		json.photos favoriteHouse.photos.limit(8)
	end
end
