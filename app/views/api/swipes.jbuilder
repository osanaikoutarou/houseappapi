json.photos do

	puts "in swipes "

	i=0
	json.array!(@photos) do |photo|
		
#		favorite = @favorites[i]
	
		json.photo photo
		json.favorite @favorites[i]
		
		#favorite
		#end
	
		i=i+1
	end
	
end