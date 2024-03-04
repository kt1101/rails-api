class AddIndexToApplicant < ActiveRecord::Migration[7.0]
  def change
    add_index :applicants, [:job_id, :profile_id], unique: true
  end
end
