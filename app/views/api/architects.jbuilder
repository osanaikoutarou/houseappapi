json.architects do
	@architects.each do |architect|
		json.architect architect
		json.houses architect.houses
		json.photos architect.photos
	end
end
