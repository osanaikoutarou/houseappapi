# Model class for Photo
class Photo < ActiveRecord::Base
  belongs_to :house
  belongs_to :architect
  has_many :favorite_photos

  acts_as_taggable
  acts_as_taggable_on :places

  mount_uploader :image, PhotoUploader
end
