# frozen_string_literal: true

class Job < ApplicationRecord
  belongs_to :user

  has_one :job_location
  has_one :location, through: :job_location
  has_many :applicants

  validates :title, presence: true
  validate :check_salary_range

  before_update :update_status
  before_destroy :delete_associated_job_location

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
    if published? && status_changed?
      set_published_date
      set_share_link
      PublishedJobMailer.published_job_mailer(self).deliver_later
    elsif draft? && status_changed?
      self.published_date = nil
      self.share_link = nil
    end
  end

  def check_salary_range
    return unless salary_from.present? && salary_to.present?

    return unless salary_from >= salary_to

    errors.add(:salary_to, 'must be greater than salary from')
  end

  def delete_associated_job_location
    job_location.destroy if job_location.present?
  end
end
