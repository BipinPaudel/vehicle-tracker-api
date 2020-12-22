class Vehicle < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_one :notification
  has_many :maintenance
end
