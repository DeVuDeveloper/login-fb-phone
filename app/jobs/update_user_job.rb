# frozen_string_literal: true

class UpdateUserJob < ActiveJob::Base
  def perform(user)
    return unless user.phone.blank?

    user.update_column(:verified, true)
  end
end
