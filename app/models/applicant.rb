class Applicant < ApplicationRecord
  belongs_to :job, optional: true
  belongs_to :profile, optional: true

  validates :job_id, presence: true
  validates :profile_id, presence: true

  enum status: {
    inprocessing: 0,
    rejected: 1
  }
end
