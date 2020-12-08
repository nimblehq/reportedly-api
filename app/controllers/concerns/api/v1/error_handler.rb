# frozen_string_literal: true

module Api
  module V1
    module ErrorHandler

      private

      def render_error(detail:, status: :unprocessable_entity)
        errors = { message: detail }

        render json: { errors: errors }, status: status
      end
    end
  end
end
