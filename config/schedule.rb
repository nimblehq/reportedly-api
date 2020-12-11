every :weekday, at: '8am' do
  runner "SlackNotificationService.init_reporting_thread"
end
