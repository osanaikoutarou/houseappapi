module Api
  module V1
    module Finder

      class ArchitectFinder < BaseFinder

        include Pageable

        def find_architects

          architects = Architect.find_by_keyword(@form.keyword)
          architects = architects.tagged_with(@form.tags, any: true) if @form.tags
          architects = architects.page(@form.page).per(@form.per_page)

          self.total = architects.total_count
          self.results = architects.all
        end

        def find_favorite_architects

          favorites = FavoriteArchitect.where(user_id: @form.current_user_id)
                          .includes(:architect)
                          .page(@form.page)
                          .per(@form.per_page)

          self.total = favorites.total_count
          self.results = favorites.map { |f| f.architect }
        end
      end

    end
  end
end


