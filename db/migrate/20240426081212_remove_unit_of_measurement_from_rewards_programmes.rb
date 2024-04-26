class RemoveUnitOfMeasurementFromRewardsProgrammes < ActiveRecord::Migration[7.1]
  def change
    remove_column :rewards_programmes, :unit_of_measurement, :string
    change_column_null :challenges, :metric_unit, false
  end
end
