module Types
  class ReportType < Types::BaseObject
    field :id, ID, null: false
    field :task_today, String, null: true
    field :obstacles_today, String, null: true
    field :user_id, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
