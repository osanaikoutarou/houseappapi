json.architects do
	json.array!(@architects) do |architect|
		json.architect architect
		json.houses architect.houses.limit(12)
		json.photos architect.photos.limit(20)
	end
end

