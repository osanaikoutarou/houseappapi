class House < ActiveRecord::Base
	has_many :photos
	belongs_to :architect
end
