class House < ApplicationRecord

  include KeywordSearchable

  belongs_to :architect
  has_many :photos
  has_many :top_photos, -> { limit(5) }, class_name: "Photo"

  def self.fields_for_find_by_keywords
    ['houses.name']
  end

end
