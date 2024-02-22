class User < ApplicationRecord
  has_secure_password
  has_many :user_tokens, dependent: :destroy
  has_many :jobs, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create
  validates :username, presence: true

  has_one_attached :avatar

end
