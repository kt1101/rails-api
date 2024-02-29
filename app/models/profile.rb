class Profile < ApplicationRecord
  has_many :applicants

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
end
