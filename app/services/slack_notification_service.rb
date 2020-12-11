# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'json'

class SlackNotificationService
  class << self
    def init_reporting_thread
      uri = URI.parse('https://slack.com/api/chat.postMessage')

      req_options = { use_ssl: uri.scheme == 'https' }

      return unless SlackThread.find_by(created_on: Time.zone.today).nil?

      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(set_request_body(uri))
      end

      result = JSON.parse(response.body)

      SlackThread.create(thread_ts: result['ts'], created_on: Time.zone.today)
    end

    private

    def set_request_body(uri)
      request = Net::HTTP::Post.new(uri)
      request.content_type = 'application/json'
      request['Authorization'] = 'Bearer xoxb-1289907288471-1577816759697-unrSMHhgnn5EocXsOHmqBynn'
      request.body = JSON.dump({
                                 'channel' => 'C01GZQ5T589',
                                 'text' => "Here are the results of Nimble - Daily Standup on #{Time.zone.now.to_date}"
                               })
      request
    end
  end
end
