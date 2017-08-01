class FavoriteArchitect < ApplicationRecord

  belongs_to :architect
  belongs_to :user

end
