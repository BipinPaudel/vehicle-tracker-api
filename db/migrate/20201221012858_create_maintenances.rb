class CreateMaintenances < ActiveRecord::Migration[6.0]
  def change
    create_table :maintenances do |t|
      t.integer :km
      t.date :date
      t.float :price
      t.text :description
      t.references :vehicle, null: false, foreign_key: true

      t.timestamps
    end
  end
end
