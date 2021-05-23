# frozen_string_literal: true

class Maintenance < ApplicationRecord
  belongs_to :vehicle

  validates :vehicle, presence: true

  validates :km,
            presence: { message: 'Kilometer driven cannot be blank' },
            numericality: { greater_than: 0, message: 'Kilometer should be greater than 0' }

  validates :price,
            presence: { message: 'Please provide the cost of total price for maintenance' },
            numericality: { greater_than: 0, message: 'Price should be greater than 0'}

  validates :date,
            presence: { message: 'Please provide maintenance date' }

  validate :date_cannot_be_future

  def date_cannot_be_future
    errors.add(:date, 'Maintenance date cannot be in the future') if date > Date.today
  end
end
