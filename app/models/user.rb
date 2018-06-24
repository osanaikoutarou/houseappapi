class User < ApplicationRecord

  include Swagger::Blocks

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :user_profile

  ROLE_USER_ANONYMOUS = 0
  ROLE_USER_REGISTERED = 10
  ROLE_ARCHITECT = 11

  def guest_user?
    self.role == User::ROLE_USER_ANONYMOUS
  end

  def fullname
    "#{self.user_profile.first_name} #{self.user_profile.last_name}"
  end

  def set_reset_password_token
    raw, enc = Devise.token_generator.generate(self.class, :reset_password_token)

    self.reset_password_token   = enc
    self.reset_password_sent_at = Time.now.utc
    save(validate: false)
    raw
  end

  swagger_schema :User do
    key :required, [:id]
    property :id, type: :string, description: 'Unique UUID'
    property :email, type: :string
    property :role, type: :integer, description: '0: guest user, 10: registered user, 11: architecture'
    property :device_uuid, type: :string, description: 'Unique device UUID'
  end
end
