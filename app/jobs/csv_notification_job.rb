class CsvNotificationJob < ApplicationJob
  queue_as :default

  def perform(url)
    Client.new(url)
  end

end
