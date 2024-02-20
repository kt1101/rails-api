class AddUserTokensToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :user_tokens, :users, foreign_key: true
  end
end
