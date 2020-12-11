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

      result = slack_result(uri, req_options)

      SlackThread.create(thread_ts: result['ts'], created_on: Time.zone.today)
    end

    private

    def slack_result(uri, req_options)
      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request_body(uri))
      end

      JSON.parse(response.body)
    end

    def request_body(uri)
      request = Net::HTTP::Post.new(uri)
      request.content_type = 'application/json'
      request['Authorization'] = ENV['SLACK_BOT_TOKEN']
      request.body = JSON.dump({
                                 channel: ENV['SLACK_CHANNEL'],
                                 text: "Here are the results of Nimble - Daily Standup on #{Time.zone.now.to_date}"
                               })
      request
    end
  end
end
