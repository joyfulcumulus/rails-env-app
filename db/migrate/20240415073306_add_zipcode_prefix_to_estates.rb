class AddZipcodePrefixToEstates < ActiveRecord::Migration[7.1]
  def change
    add_column :estates, :zipcode_prefix, :string, null: false
  end
end
