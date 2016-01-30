class FavoriteArchitect < ActiveRecord::Base
	belongs_to :architect
	belongs_to :user
end
