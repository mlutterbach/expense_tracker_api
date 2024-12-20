class Expense < ApplicationRecord
  belongs_to :user

  CATEGORIES = %w[Groceries Leisure Electronics Utilities Clothing Health Others].freeze

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :category, inclusion: { in: CATEGORIES }
  validates :date, presence: true
end
