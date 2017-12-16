module UserFilterable
  extend ActiveSupport::Concern

  included do
    belongs_to :user
  end

  module ClassMethods
    def by_user(user)
      where(user: user)
    end
  end

end