json.favorite_houses do

	json.array!(@houses) do |house|
		#json.(photo, :id, :title)
		json.house house
	end
	
end