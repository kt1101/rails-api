# frozen_string_literal: true

class Location < ApplicationRecord
  has_many :job_locations
  has_many :jobs, through: :job_locations

  validates :address, presence: true, uniqueness: true
  before_destroy :delete_associated_job_location

  private

  def delete_associated_job_location
    JobLocation.destroy_by(location_id: id) if JobLocation.where(location_id: id).present?
  end
end
