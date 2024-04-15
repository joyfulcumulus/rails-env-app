class SetNullFalseToForeignKeysInParticipationAndRewards < ActiveRecord::Migration[7.1]
  def change
    change_column_null :participations, :user_id, false
    change_column_null :participations, :challenge_id, false
    change_column_null :rewards_programmes, :target, false
    change_column_null :rewards_programmes, :unit_of_measurement, false
    change_column_null :rewards_programmes, :points, false
    change_column_null :rewards_programmes, :challenge_id, false
  end
end
