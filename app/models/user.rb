class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, :trackable, :omniauthable, omniauth_providers: %i[facebook]

  validates :phone, presence: true, unless: :skip_validation?
  validates :phone, uniqueness: {case_sensitive: false}, unless: :skip_validation?
  validates :phone, :format => { :with => /[0-9]{3}[- ]?[0-9]{3}[- ]?[0-9]{2}[- ]?[0-9]{2}/ }, unless: :skip_validation?

  after_create :update_user_verified_column_to_true
  after_create :send_pin!, unless: Proc.new { self.provider == "facebook" }

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def update_user_verified_column_to_true
    return unless phone.blank?
    update_column(:verified, true)
  end

  def skip_validation?
    return if provider.blank?
    self.save(validate: false)
  end

  def perform(user)
    nexmo = Nexmo::Client.new(api_key: 'cf003fcb', api_secret: 'X1Q3zcKyntxKVwTq')
    resp = nexmo.sms.send( from: "Ruby", to: user.phone, text: user.pin.to_s)
    user.touch(:pin_sent_at)
  end

  def reset_pin!
    update_column(:pin, rand(1000..9999))
  end

  def unverify!
    update_column(:verified, false)
  end

  def send_pin!
    reset_pin!
    unverify!
    self.perform(self)
  end

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
