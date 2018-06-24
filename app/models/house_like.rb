class HouseLike < ApplicationRecord

  include Likable
  include UserFilterable

  belongs_to :house


end
