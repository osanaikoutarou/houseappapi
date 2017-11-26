module Api
  module V1
    module Form

      module KeywordSearchable

        def keyword
          params['keyword'] || ''
        end

        def tags
          params['tags'].split(',') if params['tags']
        end
      end
    end
  end
end
