class Architect < ApplicationRecord
  has_many :houses
  has_many :photos, through: :houses

  mount_uploader :avatar, ArchitectAvatarUploader

  attr_accessor :photo_count
  attr_accessor :photo_likes_count
  attr_accessor :house_count
  attr_accessor :house_likes_count

  def self.match_favorites_for_user(user, page = 0)
    return [] if user.nil?

    # Return 20 rows per page by default
    offset = page * 20

    find_by_sql(["SELECT A1.* FROM architects A1 INNER JOIN (
                        SELECT architects.id, count(architects.id) cnt FROM architects
                        LEFT JOIN houses ON architects.id = houses.architect_id
                        LEFT JOIN photos on (houses.id = photos.house_id)
                        LEFT JOIN favorite_photos ON (photos.id = favorite_photos.photo_id and favorite_photos.user_id = :user_id)
                        GROUP BY architects.id
                      ) A2 ON (A1.id = A2.id and A2.cnt > 0)
                      ORDER BY A2.cnt DESC
                      LIMIT 20 OFFSET :offset", {user_id: user.id, offset: offset}])
  end

  def featured_photo
    photos.where(featured_photo: true).first
  end

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
