# frozen_string_literal: true

class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :share_link
      t.decimal :salary_from
      t.decimal :salary_to
      t.integer :status, default: 0
      t.datetime :published_date

      t.timestamps
    end
  end
end
