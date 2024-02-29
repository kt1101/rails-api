# frozen_string_literal: true

class AddUserToUserToken < ActiveRecord::Migration[7.0]
  def change
    add_reference :user_tokens, :user, foreign_key: true
    change_column :user_tokens, :user_id, :integer, null: true
  end
end
