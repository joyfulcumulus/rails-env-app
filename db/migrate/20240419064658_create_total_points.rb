class CreateTotalPoints < ActiveRecord::Migration[7.1]
  def change
    create_table :total_points do |t|
      t.integer :total_points, default: 0, null: false
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
