module Api
  module V1
    module Form

      class ArchitectForm < BaseForm

        include Pageable

        def keyword
          params['keyword'] || ''
        end

        def age_from
          params['age_from'] || 0
        end

        def age_to
          params['age_to'] || 99
        end


      end

    end
  end
end

