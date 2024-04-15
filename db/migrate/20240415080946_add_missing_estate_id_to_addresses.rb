class AddMissingEstateIdToAddresses < ActiveRecord::Migration[7.1]
  def change
    add_reference :addresses, :estate, foreign_key: true, null: false
  end
end
