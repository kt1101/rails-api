class AddUserIdToUserToken < ActiveRecord::Migration[7.0]
  def change
    add_column :user_tokens, :user_id, :string
  end
end
