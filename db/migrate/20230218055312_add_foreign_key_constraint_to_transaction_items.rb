class AddForeignKeyConstraintToTransactionItems < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :transaction_items, :users, column: :author_id
  end
end
