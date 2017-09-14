json.photos do
	@photos.each do |photo|
		json.photo photo
		json.house photo.house
		json.architect photo.house.architect
	end
	
end
