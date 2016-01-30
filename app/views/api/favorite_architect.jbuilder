json.favorite_architect do

	json.array!(@architects) do |architect|
		#json.(photo, :id, :title)
		json.architect architect
	end
	
end