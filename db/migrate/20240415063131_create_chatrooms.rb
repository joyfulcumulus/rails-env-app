class CreateChatrooms < ActiveRecord::Migration[7.1]
  def change
    create_table :chatrooms do |t|
      t.references :challenge, foreign_key: true, null: false
      t.references :estate, foreign_key: true, null: false
      t.timestamps
    end
  end
end
