json.photos do

puts "a"
puts @photos.count
puts @photos[0].uuid
puts @favorites

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