# frozen_string_literal: true

class FlashComponent < ViewComponent::Base
  def initialize(notice:, alert:)
    @notice = notice
    @alert = alert
  end
end