class House < ApplicationRecord

  include KeywordSearchable

  belongs_to :architect
  has_many :photos

  def self.fields_for_find_by_keywords
    ['houses.name']
  end

end
