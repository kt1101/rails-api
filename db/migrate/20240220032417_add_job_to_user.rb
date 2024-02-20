class AddJobToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :job, foreign_key: true
    change_column :users, :job_id, :integer, null: true
  end
end
