# frozen_string_literal: true

require "active_support/concern"

module NonRequired
  extend ActiveSupport::Concern
  included do
    private

    def email_required?
      false
    end

    def email_changed?
      false
    end

    def will_save_change_to_email?
      false
    end

    protected

    def password_required?
      false
    end

    def password_confirmation_required?
      false
    end
  end
end
