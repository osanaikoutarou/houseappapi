module Api
  module V1
    module Form

      class BaseForm

        attr_reader :params
        attr_accessor :current_user

        def initialize(params)
          @params = params
        end

        def [](key)
          @params[key] || params[key.to_sym]
        end

        def []=(key, value)
          @params[key] = value
        end

        def current_user_id
          @current_user.present? ? current_user.id : ''
        end

        def respond_to_missing?(method_name, include_private = false)
          model_id_method?(method_name) || model_instance_method?(method_name) || super
        end

        def method_missing(method, *args)
          if model_id_method?(method)
            @params[method.to_s]
          elsif model_instance_method?(method)
            find_model(method)
          else
            super
          end
        end


        private

        def model_id_method?(method)
          method.to_s =~ /\A(\w+)_id\z/
        end

        def model_instance_method?(method)
          model_from_name(method) rescue false
        end

        def model_from_name(model_name)
          model_name.to_s.capitalize.constantize
        end

        def find_model(method)
          @models ||= {}
          model_id = send("#{method}_id")
          @models[method] ||= model_from_name(method).find(model_id) if model_id.present?
        end

      end

    end
  end
end
