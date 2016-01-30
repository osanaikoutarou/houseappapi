json.favorite_photos do

	json.array!(@photos) do |photo|
		#json.(photo, :id, :title)
		json.photo photo
	end
	
end