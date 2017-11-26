module Api
  module V1
    module Finder

      class HouseFinder < BaseFinder

        include Pageable

        def find_houses

          houses = House.find_by_keyword(@form.keyword)
          houses = houses.tagged_with(@form.tags, any: true) if @form.tags
          houses = houses.page(@form.page).per(@form.per_page)

          self.total = houses.total_count
          self.results = houses.all
        end

        def find_favorite_houses

          favorites = FavoriteHouse.where(user_id: @form.current_user_id)
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


