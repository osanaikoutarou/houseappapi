json.houses do
	#json.array!(@houses) do |house|
	@houses.each do |house|	
		json.house house
		json.photos house.photos
		json.architect house.architect
	end
	
end
