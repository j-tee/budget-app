class CategoryTransactionItem < ApplicationRecord
  belongs_to :category
  belongs_to :transaction_item

  def self.total_category_amount(category_id)
    joins(:transaction_item).where(category_id:).sum(:amount)
  end
end
