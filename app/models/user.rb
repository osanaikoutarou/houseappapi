class User < ActiveRecord::Base
		
	before_create :generate_uuid
	
	private
	def generate_uuid
		begin
			self.uuid = SecureRandom.uuid
		end while self.class.exists?(uuid: uuid)
	end	
end
