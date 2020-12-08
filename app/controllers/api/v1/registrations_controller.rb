# frozen_string_literal: true

module Api
  module V1
    class RegistrationsController < Devise::RegistrationsController
      include ::Api::V1::ErrorHandler

      before_action :configure_sign_up_params, only: [:create]

      private

      def configure_sign_up_params
        devise_parameter_sanitizer.permit(:sign_up, keys: [:slack_id])
      end

      def respond_with(resource, _opts = {})
        if resource.errors.empty?
          render json: {
            status: { message: 'Signed up successfully.' },
            data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
          }
        else
          render_error(detail: resource.errors.full_messages.to_sentence)
        end
      end
    end
  end
end
