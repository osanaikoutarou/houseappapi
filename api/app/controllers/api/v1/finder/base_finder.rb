module Api
  module V1
    module Finder

      class BaseFinder

        attr_reader :form

        def initialize(form)
          if form.is_a?(Form::BaseForm)
            @form = form
          else
            raise "Invalid data type: BaseForm for #{self.class}"
          end
        end
      end
    end
  end
end
