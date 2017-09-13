class Architect < ApplicationRecord

  belongs_to :user
  has_many :houses
  has_many :photos, through: :houses

  mount_uploader :avatar, ArchitectAvatarUploader

  attr_accessor :photo_count
  attr_accessor :photo_likes_count
  attr_accessor :house_count
  attr_accessor :house_likes_count

  def photo_count
    photos.count
  end

  def house_count
    houses.count
  end

  def photo_likes_count
    FavoritePhoto.joins(:photo)
        .joins('INNER JOIN houses ON photos.house_id = houses.id')
        .where('houses.architect_id = ?', id)
        .count
  end

  def house_likes_count
    FavoriteHouse.joins(:house)
        .where('houses.architect_id = ?', id)
        .count
  end

end
