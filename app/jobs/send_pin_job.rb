# frozen_string_literal: true

class SendPinJob < ActiveJob::Base
  def perform(user)
    nexmo = Nexmo::Client.new(api_key: "cf003fcb", api_secret: "X1Q3zcKyntxKVwTq")
    nexmo.sms.send(from: "Ruby", to: user.phone, text: user.pin.to_s)
    user.touch(:pin_sent_at)
  end
end
