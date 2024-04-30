class CreatePointsAwards < ActiveRecord::Migration[7.1]
  def change
    create_table :points_awards do |t|
      t.integer :points, null: false
      t.references :user, foreign_key: true, null: false
      t.references :challenge_event, foreign_key: true, null: false
      t.references :challenge, foreign_key: true, null: false
      t.timestamps
    end
  end
end
