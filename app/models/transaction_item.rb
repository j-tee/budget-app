class TransactionItem < ApplicationRecord
  belongs_to :user
  has_many :category_transaction_items
  has_many :categories, through: :category_transaction_items
  validates :name, presence: true, length: { maximum: 50 }
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def self.total_user_amount(_user_id)
    where(:user_id).sum(:amount)
  end

  def self.total_category_amount(_category_id, _user_id)
    where(:category_id, :user_id).sum(:amount)
  end
end
