class Architect < ApplicationRecord

  include PgSearch

  has_many :houses
  has_many :photos, through: :houses

  mount_uploader :avatar, ArchitectAvatarUploader

  attr_accessor :photo_count
  attr_accessor :photo_likes_count
  attr_accessor :house_count
  attr_accessor :house_likes_count

  pg_search_scope :search_for, against: %i(name affiliation message introduction speciality), using: { tsearch: { any_word: true } }

  def self.match_favorites_for_user(user_id, page = 1, per_page = 25)
    return [] if user_id.blank?

    # Return 20 rows per page by default
    offset = (page - 1) * per_page

    find_by_sql(['SELECT A1.* FROM architects A1 INNER JOIN (
                        SELECT architects.id, count(architects.id) cnt FROM architects
                        LEFT JOIN houses ON architects.id = houses.architect_id
                        LEFT JOIN photos on (houses.id = photos.house_id)
                        INNER JOIN photo_likes ON (photos.id = photo_likes.photo_id and photo_likes.user_id = :user_id)
                        GROUP BY architects.id
                      ) A2 ON (A1.id = A2.id and A2.cnt > 0)
                      ORDER BY A2.cnt DESC
                      LIMIT :limit OFFSET :offset', {user_id: user_id, limit: per_page, offset: offset}])
  end

  def featured_photo
    photos.where(featured_photo: true).first || photos.first
  end

  def photo_count
    photos.count
  end

  def house_count
    houses.count
  end

  def photo_likes_count
    PhotoLike.joins(:photo)
        .joins('INNER JOIN houses ON photos.house_id = houses.id')
        .where('houses.architect_id = ?', id)
        .count
  end
  def house_likes_count
    HouseLike.joins(:house)
        .where('houses.architect_id = ?', id)
        .count
  end


  def count_photo_likes_from_user(user_id)
    PhotoLike.joins(:photo)
        .joins('INNER JOIN houses ON photos.house_id = houses.id')
        .where('houses.architect_id = ?', id)
        .where('photo_likes.user_id = ?', user_id)
        .count
  end



  def count_house_likes_from_user(user_id)
    HouseLike.joins(:house)
        .where('houses.architect_id = ?', id)
        .where('house_likes.user_id = ?', user_id)
        .count
  end


end
