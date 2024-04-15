class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :street, null: false
      t.string :zipcode, null: false
      t.string :unit_number
      t.timestamps
    end
  end
end
