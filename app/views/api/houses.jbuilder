json.houses do

	json.array!(@houses) do |house|
		json.house house
	end
	
end