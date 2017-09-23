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

    find_by_sql(["select A1.* from architects A1 inner join (
                        select architects.id, count(architects.id) cnt from architects
                        left join houses on architects.id = houses.architect_id
                        left join photos on (houses.id = photos.house_id)
                        left join favorite_photos on (photos.id = favorite_photos.photo_id and favorite_photos.user_id = :user_id)
                        group by architects.id
                        order by cnt
                      ) A2 on (A1.id = A2.id) limit 20 offset :offset", { user_id: user.id, offset: offset }])
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
