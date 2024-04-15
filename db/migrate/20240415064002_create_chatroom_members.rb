class CreateChatroomMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :chatroom_members do |t|
      t.references :user, foreign_key: true, null: false
      t.references :chatroom, foreign_key: true, null: false
      t.timestamps
    end
  end
end
