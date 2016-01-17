json.photos do
	json.array!(@photos) do |photo|
		json.(photo, :id)
	end
end