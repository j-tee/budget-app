class AddTotalAmountToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :total_amount, :decimal
  end
end
