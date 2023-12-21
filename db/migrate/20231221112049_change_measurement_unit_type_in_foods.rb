class ChangeMeasurementUnitTypeInFoods < ActiveRecord::Migration[7.1]
  def change
    # Change the column type from integer to string
    change_column :foods, :measurement_unit, :string
  end
end
