# frozen_string_literal: true

class Vehicle < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_one :notification, dependent: :destroy
  has_many :maintenance, dependent: :destroy

  validates :description, presence: { message: 'Description cannot be empty' }

  validates :price, presence: { message: 'Price cannot be empty' },
                    numericality: { greater_than: 0, message: 'Price should be greater than 0' }

  validates :buy_date, presence: { message: 'Buy Date of a vehicle cannot be empty' }

  validates :make_year, presence: { message: 'Make year cannot be empty' }


  validate :date_cannot_be_future

  def date_cannot_be_future
    errors.add(:buy_date, 'Buy date cannot be in the future') if buy_date > Date.today
    errors.add(:make_year, 'Make year cannot be in the future') if make_year.to_i > Date.today.year
  end

  def self.send_email_for_maintenance
    puts 'hey there'
  end
end
