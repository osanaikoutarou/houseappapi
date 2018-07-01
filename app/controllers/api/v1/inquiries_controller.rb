module Api
  module V1
    class InquiriesController < BaseApiController

      include Swagger::Blocks

      swagger_path '/api/v1/inquiries' do
        operation :post do
          key :summary, 'Add new inquiry'
        end
      end
      def create
        @inquiry = Inquiry.create!(permitted_params)
        @architect = Architect.where(id: permitted_params[:architect_id]).first

        email = params[:email]
        UserMailer.inquiry_received_for_user_email(@inquiry, email).deliver if email.present?
        UserMailer.inquiry_received_for_architect_email(@inquiry, @architect).deliver if @architect.present? && @architect.email.present?
      end

      protected

      def permitted_params

        params.permit(Inquiry.attribute_names)
      end


    end

  end
end