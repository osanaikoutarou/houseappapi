module Api
  module V1
    module Finder

      module Pageable

        attr_accessor :total, :results

        def page
          form.page
        end

        def per_page
          form.per_page
        end
      end
    end
  end
end
