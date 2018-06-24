module Api
  module V1
    module Finder

      class HouseFinder < BaseFinder

        include Pageable

        def find_houses

          houses = House.includes(:architect)
                       .find_by_keyword(@form.keyword)
                       .page(@form.page)
                       .per(@form.per_page)

          houses = houses.where(rank: @form['rank']) if @form['rank'].present?

          self.total = houses.total_count
          self.results = houses.all
        end

        def find_favorite_houses

          favorites = HouseLike.where(user_id: @form.current_user_id)
                          .includes(:house)
                          .page(@form.page)
                          .per(@form.per_page)

          self.total = favorites.total_count
          self.results = favorites.all.map { |f| f.house }
        end
      end

    end
  end
end


