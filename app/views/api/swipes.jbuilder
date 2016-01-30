json.photos do
<<<<<<< HEAD
	
	i=0
	
	json.array!(@photos) do |photo|
		json.photo photo
		json.house @houses[i]
		json.architect @architects[i]
		json.favorite_photo @favorite_photos[i]
			
=======

	puts "in swipes "

	i=0
	json.array!(@photos) do |photo|
		
		json.photo photo
		json.favorite @favorites[i]
		
		#favorite
		#end
	
>>>>>>> parent of 34fb912... gitignore
		i=i+1
	end
	
end