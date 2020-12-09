# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::V1::BaseController
      def show
        render json: {
          status: { message: 'User found.' },
          data: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
        }
      end

      def update
        user = current_user
        if user.update(slack_id: user_update_params[:slack_id])
          render json: {
            status: { message: 'User updated.' },
            data: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
          }
        else
          render_error(detail: user.errors.full_messages.to_sentence)
        end
      end

      private

      def user_update_params
        params.required(:user).permit(:slack_id)
      end
    end
  end
end
