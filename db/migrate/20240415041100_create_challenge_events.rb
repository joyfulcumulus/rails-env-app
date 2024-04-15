class CreateChallengeEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :challenge_events do |t|
      t.datetime :start_datetime, null: false
      t.datetime :end_datetime, null: false
      t.integer :recurrence
      t.references :challenge, foreign_key: true
      t.timestamps
    end
  end
end
