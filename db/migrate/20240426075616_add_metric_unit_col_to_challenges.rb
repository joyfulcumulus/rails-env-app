class AddMetricUnitColToChallenges < ActiveRecord::Migration[7.1]
  def change
    add_column :challenges, :metric_unit, :string
    change_column_null :rewards_programmes, :unit_of_measurement, true
  end
end
