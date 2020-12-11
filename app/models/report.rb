# frozen_string_literal: true

class Report < ApplicationRecord
  after_commit :push_to_slack, on: :create

  belongs_to :user

  validates :task_today, :obstacles_today, presence: true

  def push_to_slack
    thread_ts = SlackThread.find_by(created_on: Date.today).thread_ts

    uri = URI.parse("https://slack.com/api/chat.postMessage")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request["Authorization"] = "Bearer xoxp-1289907288471-1304856135091-1550445603463-3c641283a20c658609540e006d839495"
    request.body = JSON.dump({
                                 "channel" => "C01GZQ5T589", #env var
                                 "thread_ts" => thread_ts,
                                 "text" => " *What do you plan on tackling today?* \n #{self.task_today} \n *Okay, are you facing any blockers or unexpected issues? If yes, tell us what happened* \n #{self.obstacles_today}" ,
                                 "as_user" => true
                             })

    req_options = { use_ssl: uri.scheme == "https" }

    Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
  end
end
