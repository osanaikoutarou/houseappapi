module Api
  module V1
    module Form

      class ArchitectForm < BaseForm

        include KeywordSearchable
        include Pageable

      end

    end
  end
end

