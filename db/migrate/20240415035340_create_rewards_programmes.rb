class CreateRewardsProgrammes < ActiveRecord::Migration[7.1]
  def change
    create_table :rewards_programmes do |t|
      t.float :target
      t.string :unit_of_measurement
      t.integer :points
      t.references :challenge, foreign_key: true
      t.timestamps
    end
  end
end
