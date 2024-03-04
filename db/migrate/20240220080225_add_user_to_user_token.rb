class AddUserToUserToken < ActiveRecord::Migration[7.0]
  def change
    add_reference :user_tokens, :user, foreign_key: true
  end
end
