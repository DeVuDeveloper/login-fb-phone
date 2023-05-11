class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, :trackable, :omniauthable, omniauth_providers: %i[facebook]

  include UserValidations
  include NonRequired

  after_create :update_user_verified_column_to_true
  after_create :send_pin!, unless: Proc.new { self.provider == "facebook" }

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def update_user_verified_column_to_true
    UpdateUserJob.perform_now(self)
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
    SendPinJob.perform_now(self)
  end
end
