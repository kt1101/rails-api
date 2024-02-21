class Job < ApplicationRecord
  belongs_to :user
  validates :title, presence: true

  enum status: {
    draft: 0,
    published: 1
  }

  def self.published
    where(status: 'published')
  end

  def self.draft
    where(status: 'draft')
  end

  def set_published_date
    self.published_date = Time.zone.now
  end

  def set_share_link
    self.share_link = "http://127.0.0.1:3000/jobs/#{id}"
  end
end
