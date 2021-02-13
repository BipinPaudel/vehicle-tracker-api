class AddImagesToVehicles < ActiveRecord::Migration[6.0]
  def change
    add_column :vehicles, :images, :text
  end
end
