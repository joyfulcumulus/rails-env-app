class AddMetricObjectiveColumn < ActiveRecord::Migration[7.1]
  def change
    add_column :challenges, :metric_objective, :string
  end
end
