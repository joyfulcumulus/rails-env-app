class DeleteTotalPointsFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column(:users, :total_points)
  end
end
