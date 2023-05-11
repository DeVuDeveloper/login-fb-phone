# frozen_string_literal: true

require "active_support/concern"

module UserValidations
  extend ActiveSupport::Concern
  included do
    validates :phone, presence: true, unless: :skip_validation?
    validates :phone, uniqueness: {case_sensitive: false}, unless: :skip_validation?
    validates :phone, format: {with: ::Constants::PHONE_REGEX}, unless: :skip_validation?
  end

  def skip_validation?
    return if provider.blank?

    save(validate: false)
  end
end
