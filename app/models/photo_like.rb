class PhotoLike < ApplicationRecord

  include Likable
  include UserFilterable

  belongs_to :photo

  def self.filter_architect(architect_id)
    joins(:photo).joins('INNER JOIN houses ON photos.house_id = houses.id')
        .where('houses.architect_id = ?', architect_id)
  end
end