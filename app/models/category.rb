class Category < ApplicationRecord
  belongs_to :user
  has_many :category_transaction_items
  has_many :transaction_items, through: :category_transaction_items

  validates :name, presence: true, length: { maximum: 50 }
  validates :icon, presence: true, length: { maximum: 255 }
end
