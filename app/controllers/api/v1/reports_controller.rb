# frozen_string_literal: true

module Api
  module V1
    class ReportsController < Api::V1::BaseController
      def create

      end

      private

      def report_params
        params.required(:report).permit(:user, :task_today, :obstacles_today)
      end
    end
  end
end
