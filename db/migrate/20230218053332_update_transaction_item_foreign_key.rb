class UpdateTransactionItemForeignKey < ActiveRecord::Migration[7.0]
  def change
    rename_column :transaction_items, :user_id, :author_id
  end
end
