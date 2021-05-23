class User < ApplicationRecord
  # acts_as_token_authenticatable
  has_secure_password

  has_many :vehicles
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: { message: 'Email already exists' }
  validate :password, if: -> { new_record? || !password.nil? }

  def generate_new_authentication_token
    token = User.generate_unique_secure_token
    update_attributes authentication_token: token
  end
end
