class SendPinJob < ActiveJob::Base

  def perform(user)
    nexmo = Nexmo::Client.new(api_key: 'cf003fcb', api_secret: 'X1Q3zcKyntxKVwTq')

    user.touch(:pin_sent_at)
  end
end