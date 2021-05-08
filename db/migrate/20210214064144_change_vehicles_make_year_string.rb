class ChangeVehiclesMakeYearString < ActiveRecord::Migration[6.0]
  def change
    change_column(:vehicles, :make_year, :string)
  end
end
