class Notification < ApplicationRecord
  belongs_to :vehicle

  scope :user_notifications, ->(user_id) { joins(:vehicle).where('vehicles.user_id' => user_id) }
end
