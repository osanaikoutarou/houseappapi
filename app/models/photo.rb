# Model class for Photo
class Photo < ActiveRecord::Base

  include PgSearch

  belongs_to :house
  has_one :architect, through: :house
  has_many :favorite_photos

  #attr_accessible :name
  #attr_accessible :tag_list, :places_list

  acts_as_taggable
  acts_as_taggable_on :places

  mount_uploader :image, PhotoUploader

  pg_search_scope :search_for, against: %i(title description keyword), using: { tsearch: { any_word: true } }

  def self.fields_for_find_by_keywords
    [
        'photos.title' ,
        'photos.description'
    ]
  end

  def self.find_by_user(user_id)
    joins(:favorite_photos).where('favorite_photos.user_id = ?', user_id)
  end

end
