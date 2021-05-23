# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :vehicle

  validates :km, presence: { message: 'KM cannot be blank' },
                 numericality: { greater_than: 0, message: 'KM should be greater than zero'}

  validates :day, presence: { message: 'Day cannot be blank' },
                  numericality: { greater_than: 0, message: 'Days should be greater than zero'}

  scope :user_notifications, ->(user_id) { joins(:vehicle).where('vehicles.user_id' => user_id) }
end
