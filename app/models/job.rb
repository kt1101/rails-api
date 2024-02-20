class Job < ApplicationRecord

  enum status: {
    draft: 0,
    published: 1
  }
  belongs_to :user
  validates :title, presence: true

end
