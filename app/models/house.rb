class House < ApplicationRecord

  belongs_to :architect
  has_many :photos

end
