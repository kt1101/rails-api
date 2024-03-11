class Profile < ApplicationRecord
  has_many :applicants

  validates :email, presence: true, email_address: true
  validates :name, presence: true
end
