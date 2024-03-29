class User < ApplicationRecord
  has_secure_password
  has_many :user_tokens, dependent: :destroy
  has_many :jobs, dependent: :destroy

  validates :email, presence: true, email_address: true
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create
  validates :username, presence: true

  has_one_attached :avatar

  enum role: {
    user: 0,
    admin: 1
  }
end
