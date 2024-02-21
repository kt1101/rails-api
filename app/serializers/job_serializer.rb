class JobSerializer < ActiveModel::Serializer
  attributes :id, :title, :salary_from, :salary_to, :status, :published_date, :user_id
end
