module Api
  module V1
    module Form

      module Pageable

        def page
          params['page'] || 1
        end

        def per_page
          params['per_page'] || 25
        end

      end
    end
  end
end
