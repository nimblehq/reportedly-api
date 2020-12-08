# frozen_string_literal: true

module Api
  module V1
    class SessionsController < Devise::SessionsController
      include Api::V1::ErrorHandler

      private

      def respond_with(resource, _opts = {})
        render json: {
          status: { message: 'Logged in successfully.' },
          data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
        }
      end

      def respond_to_on_destroy
        head :ok
      end
    end
  end
end
