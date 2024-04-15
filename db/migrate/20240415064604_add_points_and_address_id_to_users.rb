class AddPointsAndAddressIdToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :total_points, :integer
    add_reference :users, :address, foreign_key: true
  end
end
