class RemoveAuthorIdFromTransactionItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :transaction_items, :author_id
  end
end
