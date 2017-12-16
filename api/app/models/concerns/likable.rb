module Likable
  extend ActiveSupport::Concern

  module ClassMethods
    def likes
      where(like: true)
    end
  end
end