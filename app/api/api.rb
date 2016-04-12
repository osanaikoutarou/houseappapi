#require 'spec_helper'
#tes

class API < Grape::API
	prefix 'api'
	version 'v1', using: :path
	format :json 
	formatter :json, Grape::Formatter::Jbuilder
	
	# http://kzy52.com/entry/2014/11/07/084023
	# 例外ハンドル 404
	rescue_from ActiveRecord::RecordNotFound do |e|
		rack_response({ message: e.message, status: 404 }.to_json, 404)
	end

	# 例外ハンドル 400
	rescue_from Grape::Exceptions::ValidationErrors do |e|
		rack_response e.to_json, 400
	end

	# 例外ハンドル 500
	rescue_from :all do |e|
		if Rails.env.development?
			raise e
		else
			error_response(message: "Internal server error", status: 500)
		end
	end

	
	####
	# helpers 
	#
	helpers do
		def authenticate!
			error!('Unauthorized. Invalid or expired token.', 401) unless current_user
		end
		
		def current_user
			# Access-Token -> ApiKey -> User
			accessToken = request.headers['Access-Token']
			apiKey = ApiKey.where(access_token: accessToken).first
			if apiKey && !apiKey.expired?
				@current_user = User.find(apiKey.user_id)
			else
				false
			end
		end
		
		def next_swipe_photos
			#Photo.where(Photo.favorite_photos.where(user_id: @current_user.id).exists.not).all
			#Photo.where("id not ?", nil) #OK
			#Photo.find_by(FavoritePhoto.find_by(:user_id => @current_user.id , :photo_id => Photo.id).eixsts.not)
			#Photo.includes(:favorite_photos).where(:favorite_photos => {:id => nil})
			
			@notShowPhotos = Array.new
			Photo.all.each do |photo|
				if !FavoritePhoto.exists?(photo_uuid:photo.uuid , user_uuid:@current_user.uuid)
					@notShowPhotos.push(photo)
				end
			end
			
			return @notShowPhotos
		end
		
	end
	
	# sample  
	# 
	# ---Jbuilder使わない場合
	# resource :items do
	# 	get '/hello' do
	# 		{hello: "world"}
	# 	end
	# end
	# ---Jbulder使う場合
	# resource :items do
	# 	get '/', jbuilder:'items' do
	# 		@items = Item.all
	# 	end
	# end
	# Viewの方に@itemsを使うコードを書く
	# app/views/api/items.jbuilder
	# json.items do
	# 	json.array!(@items) do |item|
	# 		json.(item, :id, :title, ......)
	# 	end
	# end
	
	
	####
	# api/v1/swipe
	#	
	resource :swipe do

		# パラメータ有り modeは未定義
		params do
			optional :mode, type: String
		end

		#### API No.10　スワイプのための画像取得 -> Formatter:swipes.jbuilder
		get '/', jbuilder: 'swipes' do			

			# current_user 準備
			authenticate!
			
			#TODO			
			#swipePhotos = Photo.all
			swipePhotos = next_swipe_photos
			
			favorite_photos = Array.new		#そのユーザーの
			houses = Array.new
			architects = Array.new

			swipePhotos.each do |photo|
				houses.push(photo.house)
				architects.push(photo.house.architect)
				# これヤバそう			
				favorite_photos.push(FavoritePhoto.find_by(user_uuid: @current_user.uuid , photo_uuid: photo.uuid))
			end

			@photos = swipePhotos
			@houses = houses
			@architects = architects
			@favorite_photos = favorite_photos
		end
	
	end
	
	

	####
	# api/v1/photo/:uuid
	#
	resource :photo do		
		route_param :uuid do

			#### API No.20 画像詳細取得  get /photo/:uuid -> Formatter:photo.jbuilder
			get '/', jbuilder: 'photo' do
				photo = Photo.find_by(uuid: params[:uuid])
				@photo = photo
				@favorite_photo = FavoritePhoto.find_by(photo_uuid: params[:uuid])
				@house = photo.house
				@architect = photo.house.architect
			end
			
			#### API No.11 画像LIKE  patch /photo/:uuid/like -> Formatter:photo
			patch 'like', jbuilder: 'photo' do
				
				# current_user 準備
				authenticate!
				
				# patch処理
				if FavoritePhoto.exists?(photo_uuid:params[:uuid] , user_uuid:@current_user.uuid)
					puts("in FavoritePhoto exist -> update")
					
					# patch処理
					favoritePhoto = FavoritePhoto.find_by(photo_uuid: params[:uuid]).update({
						like: true,
						pass: false,
					})
				else
					puts("in FavoritePhoto no -> create")

					favoritePhoto = FavoritePhoto.create({
						user_uuid: @current_user.uuid,
						photo_uuid: params[:uuid],
						like: true,
						pass: false,
					})
				end
				
				# response
				@photo = Photo.find_by(uuid: params[:uuid])
				@favorite_photo = favoritePhoto
				@house = @photo.house
				@architect = @photo.house.architect
						
			end
			
			#### API No.12 画像PASS　patch /photo/:uuid/pass -> Formatter:photo.jbuilder
			patch 'pass' , jbuilder: 'photo' do
				
				# current_user 準備
				authenticate!
			
				# patch処理
				if FavoritePhoto.exists?(photo_uuid:params[:uuid] , user_uuid:@current_user.uuid)
					puts("in FavoritePhoto exist -> update")
					# !をつけるとバリデーションエラーが発生した場合にActiveRecord::RecordInvalidが発生する
					favoritePhoto = FavoritePhoto.find_by(photo_uuid: params[:uuid]).update({
						like: false,
						pass: true,
					})
				else
					puts("in FavoritePhoto no -> create")
					
					favoritePhoto = FavoritePhoto.create({
						user_uuid: @current_user.uuid,
						photo_uuid: params[:uuid],
						like: false,
						pass: true,
					})
				end

				#response
				@photo = Photo.find_by(uuid: params[:uuid])
				@favorite_photo = favoritePhoto
				@house = @photo.house
				@architect = @photo.house.architect
			
			end
						
			#### API No.13 画像like,passのニュートラル　patch /photo/:uuid/neutral -> Formatter:photo.jbuilder
			patch 'neutral' , jbuilder: 'photo' do
				
				# current_user 準備
				authenticate!
			
				# patch処理
				if FavoritePhoto.exists?(photo_uuid:params[:uuid] , user_uuid:@current_user.uuid)
					puts("in FavoritePhoto exist -> update")
					# !をつけるとバリデーションエラーが発生した場合にActiveRecord::RecordInvalidが発生する
					favoritePhoto = FavoritePhoto.find_by(photo_uuid: params[:uuid]).update({
						like: false,
						pass: false,
					})
				else
					puts("in FavoritePhoto no -> create")
					
					favoritePhoto = FavoritePhoto.create({
						user_uuid: @current_user.uuid,
						photo_uuid: params[:uuid],
						like: false,
						pass: false,
					})
				end

				#response
				@photo = Photo.find_by(uuid: params[:uuid])
				@favorite_photo = favoritePhoto
				@house = @photo.house
				@architect = @photo.house.architect
			
			end
						
		end
	end	## api/v1/photo/:uuid ##



	####
	# api/v1/house/:uuid/
	#
	resource :house do
		route_param :uuid do

			#### API No.30 家詳細取得  get /house/:uuid -> Formatter:house.jbuilder
			get '/' , jbuilder: 'house' do
				@house = House.find_by(uuid: params[:uuid])
				@favorite_house = FavoriteHouse.find_by(house_uuid: params[:uuid])
			end

			#### API No.31 家LIKE　patch /house/:uuid/like -> Formatter:house.jbuilder
			patch 'like' , jbuilder: 'house' do			
				
				# current_user 準備
				authenticate!
				
				if FavoriteHouse.exists?(house_uuid:params[:uuid] , user_uuid:@current_user.uuid)
					puts("in FavoriteHouse exist -> update")
					# !をつけるとバリデーションエラーが発生した場合にActiveRecord::RecordInvalidが発生する
					favoriteHouse = FavoriteHouse.find_by(house_uuid: params[:uuid]).update({
						like: true,
						dislike: false,
					})
					favoriteArray.push(favorite)
				else
					puts("in FavoriteHouse no -> create")
					favoriteHouse = FavoriteHouse.create({
						user_uuid: @current_user.uuid ,
						house_uuid: params[:uuid],
						like: true,
						dislike: false,
					})
					favoriteArray.push(favorite)
				end
				
				# response
				@house = House.find_by(uuid: params[:uuid])
				@favorites = favoriteArray
				@architect = @house.architect
				
			end
			
			#### API No.32 家PASS　patch /house/:uuid/pass -> Formatter:house.jbuilder
			# 最初は使わないかも
			patch 'pass' , jbuilder: 'house' do
				
				# current_user 準備
				authenticate!
				
				if FavoriteHouse.exists?(house_uuid:params[:uuid] , user_uuid: @current_user.uuid)
					puts("in FavoriteHouse exist -> update")
					# !をつけるとバリデーションエラーが発生した場合にActiveRecord::RecordInvalidが発生する
					favoriteHouse = FavoriteHouse.find_by(house_uuid: params[:uuid]).update({
						like: false,
						dislike: true,
					})
				else
					puts("in FavoriteHouse no -> create")
					favoriteHouse = FavoriteHouse.create({
						user_uuid: @current_user.uuid,
						house_uuid: params[:uuid],
						like: false,
						dislike: true,
					})
				end
				
				# response
				@house = House.find_by(uuid: params[:uuid])
				@favorite_house = favoriteHouse 
				@architect = @house.architect
			
			end
			
			#### API No.33 家ニュートラル　patch /house/:uuid/neutral -> Formatter:house.jbuilder
			patch 'neutral' , jbuilder: 'house' do
				
				# current_user 準備
				authenticate!
				
				if FavoriteHouse.exists?(house_uuid:params[:uuid] , user_uuid:@current_user.uuid)
					puts("in FavoriteHouse exist -> update")
					# !をつけるとバリデーションエラーが発生した場合にActiveRecord::RecordInvalidが発生する
					favoriteHouse = FavoriteHouse.find_by(house_uuid: params[:uuid]).update({
						like: false,
						dislike: false,
					})
				else
					puts("in FavoriteHouse no -> create")
					favoriteHouse = FavoriteHouse.create({
						user_uuid: @current_user.uuid,
						house_uuid: params[:uuid],
						like: false,
						dislike: false,
					})
				end
				
				# response
				@house = House.find_by(uuid: params[:uuid])
				@favorite_house = favoriteHouse 
				@architect = @house.architect
			
			end
		
		end	
	end
			


	####
	# api/v1/architect/:uuid/
	#
	resource :architect do
		route_param :uuid do

			#### API No.40 建築家詳細取得  get /architect/:uuid  -> Formatter:architect.jbuilder
			get '/' , jbuilder: 'artchitect' do
				@architect = Architect.find_by(uuid: params[:uuid])
				@favorite_architect = FavoriteArchitect.find_by(architect_uuid: params[:uuid])
			end
			
			#### API No.41 建築家LIKE  patch /architect/:uuid/like -> Formatter:architect.jbuilder
			patch 'like' , jbuilder: 'architect' do
				
				# current_user 準備
				authenticate!
				
				if FavoriteArchitect.exists?(architect_uuid:params[:uuid] , user_uuid:@current_user.uuid)
					puts("in FavoriteArchitect exist -> update")
					# !をつけるとバリデーションエラーが発生した場合にActiveRecord::RecordInvalidが発生する
					favoriteArchitect = FavoriteArchitect.find_by(architect_uuid: params[:uuid]).update({
						like: true,
						dislike: false,
					})
				else
					puts("in FavoriteArchitect no -> create")
					favoriteArchitect = FavoriteArchitect.create({
						user_uuid: @current_user.uuid,
						architect_uuid: params[:uuid],
						like: true,
						dislike: false,
					})
				end
				
				# response 
				@architect = Architect.find_by(uuid: params[:uuid])
				@favorite_architect = favoriteArchitect
				
			end

			#### API No.42 建築家PASS  patch /architect/:uuid/pass -> Formatter:architect.jbuilder	
			patch 'pass' , jbuilder: 'architect' do
				
				# current_user 準備
				authenticate!
				
				if FavoriteArchitect.exists?(architect_uuid:params[:uuid] , user_uuid:@current_user.uuid)
					puts("in FavoriteArchitect exist -> update")
					# !をつけるとバリデーションエラーが発生した場合にActiveRecord::RecordInvalidが発生する
					favoriteArchitect = FavoriteArchitect.find_by(architect_uuid: params[:uuid]).update({
						like: false,
						dislike: true,
					})
				else
					puts("in FavoriteArchitect no -> create")
					favoriteArchitect = FavoriteArchitect.create({
						user_uuid: @current_user.uuid,
						architect_uuid: params[:uuid],
						like: false,
						dislike: true,
					})
				end
				
				# response
				@architect = Architect.find_by(uuid: params[:uuid]) 
				@favorite_architect = favoriteArchitect
			end
			
			
			#### API No.43 建築家ニュートラル  patch /architect/:uuid/neutral -> Formatter:architect.jbuilder	
			patch 'neutral' , jbuilder: 'architect' do
				
				# current_user 準備
				authenticate!
				
				if FavoriteArchitect.exists?(architect_uuid:params[:uuid] , user_uuid:@current_user.uuid)
					puts("in FavoriteArchitect exist -> update")
					# !をつけるとバリデーションエラーが発生した場合にActiveRecord::RecordInvalidが発生する
					favoriteArchitect = FavoriteArchitect.find_by(architect_uuid: params[:uuid]).update({
						like: false,
						dislike: false,
					})
				else
					puts("in FavoriteArchitect no -> create")
					favoriteArchitect = FavoriteArchitect.create({
						user_uuid: @current_user.uuid,
						architect_uuid: params[:uuid],
						like: false,
						dislike: false,
					})
				end
				
				# response
				@architect = Architect.find_by(uuid: params[:uuid]) 
				@favorite_architect = favoriteArchitect
			end

			
		end
	end


	####
	# api/v1/favorite/
	#
	resource :favorites do
		
		#### API No.50 お気に入り三種全て
		params do
			optional :offset, type:Integer, default:0
			optional :limit, type:Integer, default:50
		end		
		get '/' , jbuilder: 'favorites_allcontents' do
			
			# current_user 準備
			authenticate!
				
			@photos 		= FavoritePhoto.where(user_uuid: @current_user.uuid).limit(:limit).offset(:offset)
			@houses 		= FavoriteHouse.where(user_uuid: @current_user.uuid).limit(:limit).offset(:offset)
			@architects = FavoriteArchitect.where(user_uuid: @current_user.uuid).limit(:limit).offset(:offset)
		end
		
		### API No.51 お気に入り写真 取得
		resource :photos do
			params do
				optional :offset, type:Integer , default:0
				optional :limit, type:Integer, default:50
			end
			get '/' , jbuilder: 'favorite_photos' do
				
				# current_user 準備
				authenticate!
				
				@favoritePhotos = Array.new
				Photo.all.each do |photo|
					if FavoritePhoto.exists?(photo_uuid:photo.uuid , user_uuid:@current_user.uuid)
						@favoritePhotos.push(photo)
					end
				end
			
				#TODO:favoriteどうしよ
			end
		end
		
		### API No.52 お気に入り家 取得
		resource :houses do
			params do
				optional :offset, type:Integer , default:0
				optional :limit, type:Integer, default:50
			end
			get '/' , jbuilder: 'favorite_houses' do
				
				# current_user 準備
				# authenticate!
				
				#######　ここ　ここここ
				@favoriteHouses = House.all
				
				print(@favoriteHouses)
				
				
			end
		end
		
		### API No.53 お気に入り建築家 取得
		resource :architects do
			params do
				optional :offset, type:Integer , default:0
				optional :limit, type:Integer, default:50
			end
			get '/' , jbuilder: 'favorite_architects' do
				
				# current_user 準備
				authenticate!
				
				@architects = FavoriteArchitect.where(user_uuid: @current_user.uuid).limit(:limit).offset(:offset)
			end
		end

	end


	####
	# api/v1/matching/
	#
	resource :matching do
		
		#### API No.60 おすすめ　取得
		params do
			optional :offset, type:Integer , default:0
			optional :limit, type:Integer, default:50
		end
		get '/' , jbuilder: 'matching_allcontents' do
			#TODO
			@architects = Architect.all
		end
	end


	####
	# api/v1/user/activation
	#
	resource :user do
		
		#### API No.90 User Activation
		post ':activation' , jbuilder: 'activation' do  
			
			# 新規user			
			newUser = User.create({	
			})
			# 新規apikey
			apiKey = ApiKey.create({
					user_id: newUser.id,
					expires_at: DateTime.new(2099,1,1)
			})
			
			@User = newUser
			@ApiKey = apiKey
			
		end
		
	end
end