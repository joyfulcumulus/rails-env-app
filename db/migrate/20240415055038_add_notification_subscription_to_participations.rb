class AddNotificationSubscriptionToParticipations < ActiveRecord::Migration[7.1]
  def change
    add_column :participations, :notification_subscription, :boolean
  end
end
