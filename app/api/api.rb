#require 'spec_helper'


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

	
	# # #
	
	helpers do
		# TODO:わからん
		def current_user
			@current_user ||= User.authorize! (env)
		end
    
		def authenticate!
			error!('401 Unauthorized', 401) unless current_user
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
			#TODO			
			@photos = Photo.all
		end
	
	end
	
	
  
  ####
  # api/v1/photo/:uuid
  #
	resource :photo do		
		route_param :uuid do
        
			#### API No.20 画像詳細取得  get /photo/:uuid -> Formatter:photo.jbuilder
			get '/', jbuilder: 'photo' do
				@photo = Photo.find_by(uuid: params[:uuid])
			end
			
			#### API No.11 画像LIKE  patch /photo/:uuid/like -> Formatter:swipes.jbuilder
			patch 'like', jbuilder: 'swipes' do
				
				# patch処理
				if FavoritePhoto.exists?(photo_uuid:params[:uuid] , user_uuid:"testUserUUID")
					puts("in FavoritePhoto exist -> update")
					
					# patch処理
					FavoritePhoto.find_by(photo_uuid: params[:uuid]).update({
						like: true,
						pass: false,
					})
				else
					puts("in FavoritePhoto no -> create")

					FavoritePhoto.create({
						user_uuid: "testUserUUID",
						photo_uuid: params[:uuid],
						like: true,
						pass: false,
					})
				end
				
				# response
				#TODO
				@photos = Photo.all
						
			end
			
			#### API No.12 画像PASS　patch /photo/:uuid/pass -> Formatter:photo_pass.jbuilder
			patch 'pass' , jbuilder: 'swipes' do
				
				# patch処理
				if FavoritePhoto.exists?(photo_uuid:params[:uuid] , user_uuid:"testUserUUID")
					puts("in FavoritePhoto exist -> update")
					# !をつけるとバリデーションエラーが発生した場合にActiveRecord::RecordInvalidが発生する
					FavoritePhoto.find_by(photo_uuid: params[:uuid]).update({
						like: false,
						pass: true,
					})
				else
					puts("in FavoritePhoto no -> create")
					
					FavoritePhoto.create({
						user_uuid: "testUserUUID",
						photo_uuid: params[:uuid],
						like: false,
						pass: true,
					})
					
					#response
					#TODO
					@photos = Photo.all
					
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
			end

			#### API No.31 家LIKE　get /house/:uuid/like -> Formatter:swipes.jbuilder
			patch 'like' , jbuilder: 'swipe' do
				if FavoriteHouse.exists?(house_uuid:params[:uuid] , user_uuid:"testUserUUID")
					puts("in FavoriteHouse exist -> update")
					# !をつけるとバリデーションエラーが発生した場合にActiveRecord::RecordInvalidが発生する
					FavoriteHouse.find_by(house_uuid: params[:uuid]).update({
						like: true,
						dislike: false,
					})
				else
					puts("in FavoriteHouse no -> create")
					FavoriteHouse.create({
						user_uuid: "testUserUUID",
						house_uuid: params[:uuid],
						like: true,
						dislike: false,
					})
				end
				
				# response
				#TODO
				@photos = Photo.all
				
			end
			
			#### API No.32 家PASS　get /house/:uuid/pass -> Formatter:swipes.jbuilder
			patch 'pass' , jbuilder: 'swipe' do
				if FavoriteHouse.exists?(house_uuid:params[:uuid] , user_uuid:"testUserUUID")
				puts("in FavoriteHouse exist -> update")
				# !をつけるとバリデーションエラーが発生した場合にActiveRecord::RecordInvalidが発生する
				FavoriteHouse.find_by(house_uuid: params[:uuid]).update({
					like: false,
					dislike: true,
				})
			else
				puts("in FavoriteHouse no -> create")
				FavoriteHouse.create({
					user_uuid: "testUserUUID",
					house_uuid: params[:uuid],
					like: false,
					dislike: true,
				})
				
				# response
				#TODO
				@photos = Photo.all
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
			end
			
			#### API No.41 建築家LIKE  patch /architect/:uuid/like -> Formatter:swipes.jbuilder
			patch 'like' , jbuilder: 'swipes' do
				if FavoriteArchitect.exists?(architect_uuid:params[:uuid] , user_uuid:"testUserUUID")
				puts("in FavoriteArchitect exist -> update")
				# !をつけるとバリデーションエラーが発生した場合にActiveRecord::RecordInvalidが発生する
				FavoriteArchitect.find_by(architect_uuid: params[:uuid]).update({
					like: true,
					dislike: false,
				})
				else
					puts("in FavoriteArchitect no -> create")
					FavoriteArchitect.create({
						user_uuid: "testUserUUID",
						architect_uuid: params[:uuid],
						like: true,
						dislike: false,
					})
				end
				
				# response 
				#TODO
				@photos = Photo.all
			end

			#### API No.42 建築家PASS  patch /architect/:uuid/pass -> Formatter:swipes.jbuilder	
			patch 'pass' , jbuilder: 'swipes' do
				if FavoriteArchitect.exists?(architect_uuid:params[:uuid] , user_uuid:"testUserUUID")
					puts("in FavoriteArchitect exist -> update")
					# !をつけるとバリデーションエラーが発生した場合にActiveRecord::RecordInvalidが発生する
					FavoriteArchitect.find_by(architect_uuid: params[:uuid]).update({
						like: false,
						dislike: true,
					})
				else
					puts("in FavoriteArchitect no -> create")
					FavoriteArchitect.create({
						user_uuid: "testUserUUID",
						architect_uuid: params[:uuid],
						like: false,
						dislike: true,
					})
				end
				
				# response
				#TODO
				@photos = Photo.all
			end
    end
	end


	####
	# api/v1/favorite/
	#
	resource :favorites do
		
		#### API No.60 お気に入り三種全て
		params do
			optional :offset, type:Integer, default:0
			optional :limit, type:Integer, default:50
		end		
		get '/' , jbuilder: 'favorites' do
			@photos 		= FavoritePhoto.where(user_uuid: "testUserUUID").limit(limit).offset(offset)
			@houses 		= FavoriteHouse.where(user_uuid: "testUserUUID").limit(limit).offset(offset)
			@architects = FavoriteArchitect.where(user_uuid: "testUserUUID").limit(limit).offset(offset)
		end
		
		### API No.61 お気に入り写真 取得
		resource :photos do
			params do
				optional :offset, type:Integer , default:0
				optional :limit, type:Integer, default:50
			end
			get '/' , jbuilder: 'favorite_photos' do
				@photos 		= FavoritePhoto.where(user_uuid: "testUserUUID").limit(limit).offset(offset)
			end
		end
		
		### API No.62 お気に入り家 取得
		resource :houses do
			params do
				optional :offset, type:Integer , default:0
				optional :limit, type:Integer, default:50
			end
			get '/' , jbuilder: 'favorite_houses' do
				@houses 		= FavoriteHouse.where(user_uuid: "testUserUUID").limit(limit).offset(offset)
			end
		end
		
		### API No.63 お気に入り建築家 取得
		resource :architects do
			params do
				optional :offset, type:Integer , default:0
				optional :limit, type:Integer, default:50
			end
			get '/' , jbuilder: 'favorite_architects' do
				@architects = FavoriteArchitect.where(user_uuid: "testUserUUID").limit(limit).offset(offset)
			end
		end

	end









	
	# api/v1/user/activation
	resource :user do
		
		# API No.60 User Activation
		post :activation do
			# SecureRandom 
			
			# User.create(
				# uuid: SecureRandom.uuid,
				# name_sei:  
			# )			
			
		end
			
		# t.string :uuid
      # t.text :name_sei
      # t.text :name_mei
      # t.text :name_sei_kana
      # t.text :name_mei_kana
      
      # t.string :gender
      # t.string :postal_code
      # t.string :prefecture
      # t.text :city
      # t.text :address1
      # t.text :address2
		
		
		
      
      
		route_param :uuid do
        
			# API No.40 建築家詳細取得  get /architect/:uuid
			get do
				Architect.find_by(uuid: params[:uuid])
			end
		
		end
       
		# API No.41  建築家LIKE　 patch /architect/:uuid/like
		patch :like do
			if FavoriteArchitect.exists?(architect_uuid:params[:uuid] , user_uuid:"testUserUUID")
				puts("in FavoriteArchitect exist -> update")
				# !をつけるとバリデーションエラーが発生した場合にActiveRecord::RecordInvalidが発生する
				FavoriteArchitect.find_by(architect_uuid: params[:uuid]).update({
					like: true,
					dislike: false,
				})
			else
				puts("in FavoriteArchitect no -> create")
				FavoriteArchitect.create({
					user_uuid: "testUserUUID",
					architect_uuid: params[:uuid],
					like: true,
					dislike: false,
				})
			end
		end

		# API No.42  建築家DISLIKE　 patch /architect/:uuid/dislike       
		patch :dislike do
			if FavoriteArchitect.exists?(architect_uuid:params[:uuid] , user_uuid:"testUserUUID")
				puts("in FavoriteArchitect exist -> update")
				# !をつけるとバリデーションエラーが発生した場合にActiveRecord::RecordInvalidが発生する
				FavoriteArchitect.find_by(architect_uuid: params[:uuid]).update({
					like: false,
					dislike: true,
				})
			else
				puts("in FavoriteArchitect no -> create")
				FavoriteArchitect.create({
					user_uuid: "testUserUUID",
					architect_uuid: params[:uuid],
					like: false,
					dislike: true,
				})
			end
		end








    # API No.12 pass
    patch :pass do
         
      route_param :uuid do
        
        FavoritePhoto.create!({
             user_uuid: current_user,
             like: false,
             pass: true
           })           
      end
      
    end
       
  end
  
  
  # api/v1/house
  resource :house do
 
    # API No.30 家詳細取得 get /house/uuid
    route_param :uuid do
      get do
        House.find(params[:uuid])      
      end
    end
    
    # API No.31 家LIKE patch /house/like/:uuid
    patch :like do
      route_param :uuid do
        
        
        FavoriteHouse.create!({
          user_uuid: current_user,
          like: true,
          dislike: false
        })
        
      end
    end
    
    # API No.32 家DISLIKE patch /house/dislike/uuid
    patch :dislike do
      route_param :uuid do
        
        FavoriteHouse.create!({
          user_uuid: current_user,
          like: false,
          dislike: true
        })
      end
    end
    
  end
  
  
  # get api/v1/architect/:uuid
  resource :architect do
    
    params do
      requires :uuid , type: String
    end
    route_param :uuid do
      get do
        Architect.find(params[:uuid])
      end
    end
    
  end
  

  

end
