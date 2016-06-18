json.favorite_architects do
	json.array!(@favoriteArchitects) do |favoriteArchitect|
		json.favorite_architect favoriteArchitect
		json.houses favoriteArchitect.houses
		json.photos favoriteArchitect.houses,photos
	end
end