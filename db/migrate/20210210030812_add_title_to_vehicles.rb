class AddTitleToVehicles < ActiveRecord::Migration[6.0]
  def change
    add_column :vehicles, :title, :string
  end
end
