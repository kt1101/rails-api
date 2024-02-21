class User < ApplicationRecord
  has_secure_password
  has_many :user_tokens, dependent: :destroy
  has_many :jobs, dependent: :destroy

  # validates :email, presence: true, uniqueness: true
  # validates :password, presence: true
  # validates :password_confirmation, presence: true
  # validates :username, presence: true

  has_one_attached :image

end
