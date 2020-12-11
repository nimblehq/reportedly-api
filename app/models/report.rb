# frozen_string_literal: true

class Report < ApplicationRecord
  after_commit :push_to_slack, on: :create

  belongs_to :user

  validates :task_today, :obstacles_today, presence: true

  def push_to_slack
    thread_ts = SlackThread.find_by(created_on: Time.zone.today).thread_ts

    uri = URI.parse('https://slack.com/api/chat.postMessage')

    req_options = { use_ssl: uri.scheme == 'https' }

    Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(set_request_body(uri, thread_ts))
    end
  end

  private

  def set_request_body(uri, thread_ts)
    request = Net::HTTP::Post.new(uri)
    request.content_type = 'application/json'
    request['Authorization'] = ENV['SLACK_REPLY_TOKEN']
    request.body = JSON.dump({
                               'channel' => ENV['SLACK_CHANNEL'], # env var
                               'thread_ts' => thread_ts,
                               'text' => format_message,
                               'as_user' => true
                             })
    request
  end

  def format_message
    "*What do you plan on tackling today?* \n
    #{task_today} \n
    *Okay, are you facing any blockers or unexpected issues? If yes, tell us what happened* \n
    #{obstacles_today}"
  end
end
