json.favorite_architects do
	json.array!(@favoriteArchitects) do |favoriteArchitect|
		json.favorite_architect favoriteArchitect
		json.houses favoriteArchitect.houses
		json.photos favoriteArchitect.photos.limit(4)
	end
end