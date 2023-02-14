# frozen_string_literal: true

class CreateCategoryTransactionItems < ActiveRecord::Migration[7.0]
  def change
    create_table :category_transaction_items do |t|
      t.references :category, null: false, foreign_key: true
      t.references :transaction_item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
