# Model class for Photo
class Photo < ActiveRecord::Base

  belongs_to :house
  has_one :architect, through: :house

  acts_as_taggable
  acts_as_taggable_on :places

  mount_uploader :image, PhotoUploader
end
