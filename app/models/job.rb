class Job < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validate :check_salary_range
  before_update :update_status

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
    self.share_link = "http://127.0.0.1:3000/jobs/#{id}/share_link"
  end

  private

  def update_status
    if self.published? && self.status_changed?
      set_published_date
      set_share_link
    elsif self.draft? && self.status_changed?
      self.published_date = nil
      self.share_link = nil
    end
  end

  def check_salary_range
    return unless salary_from.present? && salary_to.present?
    if salary_from >= salary_to
      errors.add(:salary_to, "must be greater than salary from")
    end
  end
  
end
