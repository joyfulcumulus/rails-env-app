class CreateActions < ActiveRecord::Migration[7.1]
  def change
    create_table :actions do |t|
      t.float :recyclable_weight, null: false
      t.references :user, foreign_key: true, null: false
      t.references :challenge_event, foreign_key: true, null: false
      t.timestamps
    end
  end
end
