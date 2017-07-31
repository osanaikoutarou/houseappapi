
class Architect < ActiveRecord::Base
  has_many :houses
  has_many :photos, through: :houses
  has_many :favorite_architect

  belongs_to :user
end
