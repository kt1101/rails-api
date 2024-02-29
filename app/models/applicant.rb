# frozen_string_literal: true

class Applicant < ApplicationRecord
  belongs_to :job, optional: true
  belongs_to :profile, optional: true

  validates :job_id, presence: true
  validates :profile_id, presence: true
  validates_uniqueness_of :job_id, scope: [:profile_id]

  enum status: {
    inprocessing: 0,
    rejected: 1
  }
end
