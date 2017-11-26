module Api
  module V1
    module Form

      class PhotoForm < BaseForm

        include KeywordSearchable
        include Pageable

      end
    end
  end
end

