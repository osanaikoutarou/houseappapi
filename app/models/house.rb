class House < ActiveRecord::Base
	belongs_to :architect
	has_many :photos
end
