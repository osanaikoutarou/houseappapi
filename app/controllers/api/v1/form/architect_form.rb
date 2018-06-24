module Api
  module V1
    module Form

      class ArchitectForm < BaseForm

        include Pageable

        def keyword
          params['keyword'] || ''
        end

        def prefecture
          params['prefecture'] || ''
        end

        def age_from
          params['age_from'] || nil
        end

        def age_to
          params['age_to'] || nil
        end
      end

    end
  end
end

