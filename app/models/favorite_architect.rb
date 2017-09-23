class FavoriteArchitect < ApplicationRecord

  include Likable
  include UserFilterable

  belongs_to :architect

end
