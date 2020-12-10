# frozen_string_literal: true

class ReportSerializer
  include JSONAPI::Serializer
  attributes :id, :user, :task_today, :obstacles_today
end
