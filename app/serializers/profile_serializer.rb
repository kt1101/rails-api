# frozen_string_literal: true

class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :name, :email
end
