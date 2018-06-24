module Api
  module V1
    module Finder

      class ArchitectFinder < BaseFinder

        include Pageable

        def find_architects

          architects = Architect.where('1 = 1')
          architects = architects.search_for(@form.keyword) if @form.keyword.present?
          architects = architects.where(prefecture: @form.prefecture) if @form.prefecture.present?

          if @form.age_from.present?
            architects = architects.where('year_of_birth <= ?', Time.new.year - @form.age_from.to_i)
          end

          if @form.age_to.present?
            architects = architects.where('year_of_birth >= ?', Time.new.year - @form.age_to.to_i)
          end

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
          self.results = favorites.map &:architect
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


