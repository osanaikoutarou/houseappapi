module Api
  module V1
    module Finder

      class PhotoFinder < BaseFinder

        include Pageable

        def find_photos
          photos = Photo.where('1 = 1')
          photos = photos.joins(:house).where('houses.rank' => @form['rank']) if @form['rank'].present?
          photos = photos.search_for(@form.keyword) if @form.keyword.present?
          photos = photos.tagged_with(@form['tags'], any: true) if @form['tags'].present?
          photos = photos.tagged_with(@form['room'], on: :places) if @form['room'].present?


          photos = photos.page(@form.page).per(@form.per_page)

          self.total = photos.total_count
          self.results = photos.all
        end

        def find_favorite_photos
          favorites = PhotoLike.where(user_id: @form.current_user_id)
                          .includes(:photo)
                          .page(@form.page)
                          .per(@form.per_page)

          self.total = favorites.total_count
          self.results = favorites.all.map { |f| f.photo }
        end
      end

    end
  end
end


