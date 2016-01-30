class House < ActiveRecord::Base
	has_many :photos
	belongs_to :architect
	has_many :favorite_houses
end
