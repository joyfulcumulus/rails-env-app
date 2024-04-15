class CreateClaims < ActiveRecord::Migration[7.1]
  def change
    create_table :claims do |t|
      t.integer :points, null: false
      t.integer :cdc_voucher_value, null: false
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
