class AddKmDrivenToVehicles < ActiveRecord::Migration[6.0]
  def change
    add_column :vehicles, :km_driven, :integer
  end
end
