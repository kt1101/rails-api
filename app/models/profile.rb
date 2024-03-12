class Profile < ApplicationRecord
  include MeiliSearch::Rails

  has_many :applicants

  validates :email, presence: true, email_address: true
  validates :name, presence: true

  meilisearch do
    add_attribute :applicant_attribute

    displayed_attributes [:id, :email, :name, :created_at, :updated_at, :applicant_attribute]
    filterable_attributes [:email]
    sortable_attributes [:updated_at, :created_at]
  end

  private

  def applicant_attribute
    applicants.map do |applicant|
      {
        job_id: applicant.job_id,
        applicant_id: applicant.id,
        status: applicant.status
      }
    end
  end
end
