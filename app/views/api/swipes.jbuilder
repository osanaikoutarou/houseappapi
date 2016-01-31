json.photos do
	i=0
	json.array!(@photos) do |photo|
		json.photo photo
		json.house @houses[i]
		json.architect @architects[i]
		json.favorite_photo @favorite_photos[i]

		i=i+1
	end
	
end