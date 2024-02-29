# frozen_string_literal: true

class CreateJobLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :job_locations do |t|
      t.references :job
      t.references :location
    end
  end
end
