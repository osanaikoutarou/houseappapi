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

        def keyword_or_tags
          tags = []
          tags << params['tags'].split(',') if params['tags']
          tags << params['keyword'].split(' ') if params['keyword']
          tags
        end
      end
    end
  end
end
