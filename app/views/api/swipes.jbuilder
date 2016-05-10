json.photos do
	i=0
	json.array!(@photos) do |photo|
		json.photo photo
		json.house photo.house
		json.architect photo.house.architect
		json.favorite_photo photo.favorite_photo

		i=i+1
	end
	
end