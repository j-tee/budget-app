class RemoveTotalAmountFromCategories < ActiveRecord::Migration[7.0]
  def change
    remove_column :categories, :TotalAmount, :decimal
  end
end
