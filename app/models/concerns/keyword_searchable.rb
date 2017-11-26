# frozen_string_literal: true

module KeywordSearchable

  extend ActiveSupport::Concern

  included do
    scope :find_by_keyword, ->(keyword) { where_with_keyword(keyword) }
  end

  class_methods do
    def fields_for_find_by_keywords
      []
    end

    def where_with_keyword(keyword)
      conditions = fields_for_find_by_keywords.map do |f|
        "#{f} LIKE :keyword"
      end
      where(conditions.join(' OR '), keyword: "%#{keyword}%")
    end
  end
end
