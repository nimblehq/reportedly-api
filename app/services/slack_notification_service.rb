# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'json'

class SlackNotificationService
  def self.init_reporting_thread
    uri = URI.parse("https://slack.com/api/chat.postMessage")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request["Authorization"] = "Bearer xoxb-1289907288471-1577816759697-unrSMHhgnn5EocXsOHmqBynn"
    request.body = JSON.dump({
                                 "channel" => "C01GZQ5T589",
                                 "text" => "Here are the results of Nimble - Daily Standup from #{Time.now.to_date}",
                             })

    req_options = { use_ssl: uri.scheme == "https" }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    result = JSON.parse(response.body)

    if SlackThread.find_by(created_on: Date.today).nil?
      SlackThread.create(thread_ts: result['ts'], created_on: Date.today)
    end
  end
end
