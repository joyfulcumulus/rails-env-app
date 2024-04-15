class AddColumnsToChallenges < ActiveRecord::Migration[7.1]
  def change
    add_column :challenges, :start_date, :datetime, null: false
    add_column :challenges, :end_date, :datetime, null: false
    add_column :challenges, :participant_criteria, :string, null: false
    change_column_null :challenges, :name, false
    change_column_null :challenges, :description, false
  end
end
