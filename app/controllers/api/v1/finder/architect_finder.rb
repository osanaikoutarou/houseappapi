module Api
  module V1
    module Finder

      class ArchitectFinder < BaseFinder

        include Pageable

        def find_architects

          architects = Architect.where('1 = 1')
          architects = architects.search_for(@form.keyword) if @form.keyword.present?
          architects = architects.page(@form.page).per(@form.per_page)

          self.total = architects.total_count
          self.results = architects.all
        end

        def find_favorite_architects

          favorites = ArchitectLike.where(user_id: @form.current_user_id)
                          .includes(:architect)
                          .page(@form.page)
                          .per(@form.per_page)

          self.total = favorites.total_count
          self.results = favorites.map { |f| f.architect }
        end

        def match_architects
          self.results = Architect.match_favorites_for_user(form.current_user_id,
                                                            form.page,
                                                            form.per_page)
        end

      end

    end
  end
end


