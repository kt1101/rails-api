class Profile < ApplicationRecord
  has_many :applicants

  validates :email, presence: true
  validates :name, presence: true
end
