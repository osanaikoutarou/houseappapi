class FavoritePhoto < ApplicationRecord

  belongs_to :photo
  belongs_to :user

  scope :filter_architect, -> (architect_id) {joins(:photo).joins('INNER JOIN houses ON photos.house_id = houses.id').where('houses.architect_id = ?', architect_id)}


  def self.filter_architect(architect_id)
    joins(:photo).joins('INNER JOIN houses ON photos.house_id = houses.id')
        .where('houses.architect_id = ?', architect_id)
  end

end