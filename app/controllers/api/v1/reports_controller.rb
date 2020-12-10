# frozen_string_literal: true

module Api
  module V1
    class ReportsController < Api::V1::BaseController
      def show
        render json: {
          status: { message: 'User Reports.' },
          data: ReportSerializer.new(current_user_reports, is_collection: true)
        }
      end

      def create
        report = Report.new(report_params)

        if report.save
          render json: {
            status: { message: 'Report submitted, Thanks' }
          }
        else
          render_error(detail: report.errors.full_messages.to_sentence)
        end
      end

      private

      def report_params
        params.required(:report).permit(:user_id, :task_today, :obstacles_today)
      end

      def current_user_reports
        current_user.reports.last(5).reverse
      end
    end
  end
end
