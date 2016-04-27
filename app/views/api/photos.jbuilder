json.photos do

	json.array!(@photos) do |photo|
		json.photo photo
		json.house photo.house
	end
	
end