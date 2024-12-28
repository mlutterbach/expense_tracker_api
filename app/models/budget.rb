class Budget < ApplicationRecord
  belongs_to :user

  validates :month, presence: true
  validates :month, uniqueness: { scope: :user_id, message: "budget for this month already exists" }
  validates :amount, numericality: { greater_than: 0, message: "must be a positive number" }
end
