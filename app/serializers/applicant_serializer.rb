# frozen_string_literal: true

class ApplicantSerializer < ActiveModel::Serializer
  attributes :id, :status, :job_id, :profile_id
end
