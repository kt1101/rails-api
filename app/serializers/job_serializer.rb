class JobSerializer < ActiveModel::Serializer
  include JSONAPI::Serializer

  attributes :id, :title, :salary_from, :salary_to, :status, :published_date, :user_id, :share_link
end
