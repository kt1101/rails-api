# frozen_string_literal: true

class ApplicantPolicy < ApplicationPolicy
  attr_reader :current_user

  def initialize(current_user, applicant)
    @current_user = current_user
    @applicant = applicant
  end

  def index?
    @current_user.id == Job.where(id: @applicant.pluck(:job_id).uniq).pluck(:user_id).uniq[0]
  end

  def update?
    @current_user == @applicant.job.user
  end
end
