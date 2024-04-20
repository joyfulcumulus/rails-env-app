class AddMetricNameToChallenges < ActiveRecord::Migration[7.1]
  def change
    add_column :challenges, :metric_name, :string, null: false
  end
end
