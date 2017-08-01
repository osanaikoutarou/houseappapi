
class Architect < ApplicationRecord

  belongs_to :user
  has_many :houses
  has_many :photos, through: :houses

  mount_uploader :avatar, ArchitectAvatarUploader
end
