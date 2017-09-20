json.architects do
	json.array!(@architects) do |architect|
		json.architect architect
		json.houses architect.houses
		json.photos architect.photos
	end
end
