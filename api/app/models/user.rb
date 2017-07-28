class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :user_profile

  ROLE_USER_ANONYMOUS = 0
  ROLE_USER_REGISTERED = 10
  ROLE_ARCHITECT = 11

end
