# frozen_string_literal: true

class RejectApplicantService < ApplicationService
  def initialize(applicant:)
    @applicant = applicant
  end

  def call
    update_status
  end

  private

  def update_status
    @applicant.update!(status: 'rejected')
    ApplicantRejectedMailer.applicant_rejected_mailer(@applicant).deliver_later
  end
end
