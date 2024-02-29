# frozen_string_literal: true

class AddUserToJob < ActiveRecord::Migration[7.0]
  def change
    add_reference :jobs, :user, foreign_key: true
    change_column :jobs, :user_id, :integer, null: true
  end
end
