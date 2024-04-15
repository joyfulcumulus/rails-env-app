class CreateParticipations < ActiveRecord::Migration[7.1]
  def change
    create_table :participations do |t|
      t.integer :points, default: 0
      t.references :user, foreign_key: true
      t.references :challenge, foreign_key: true
      t.timestamps
    end
  end
end
