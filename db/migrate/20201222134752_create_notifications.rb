class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :km
      t.integer :day
      t.references :vehicle, null: false, foreign_key: true

      t.timestamps
    end
  end
end
