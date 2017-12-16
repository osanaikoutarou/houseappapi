module Api
  module V1
    module Form

      class HouseForm < BaseForm

        include KeywordSearchable
        include Pageable

      end

    end
  end
end

