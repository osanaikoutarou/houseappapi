class User < ActiveRecord::Base
  
  has_many :favorite_photos
  has_many :favorite_houses
  has_many :favorite_architects
		
	before_create :generate_uuid
	
	private
	def generate_uuid
		begin
			self.uuid = SecureRandom.uuid
		end while self.class.exists?(uuid: uuid)
	end	
end
