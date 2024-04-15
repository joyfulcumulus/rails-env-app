class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.references :challenge, foreign_key: true, null: false
      t.references :address, foreign_key: true, null: false
      t.timestamps
    end
  end
end
