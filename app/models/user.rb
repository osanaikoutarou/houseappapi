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
end
