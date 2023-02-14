class TransactionItemsController < ApplicationController
  def index; end

  def new
    @transaction_item = TransactionItem.new
  end

  def create
    @category = Category.find(params[:id])
    @user = current_user
    @transaction_item = TransactionItem.new(params.require(:new_transaction_item).permit(:name, :amount))
    @transaction_item.user = @user
    if @transaction_item.save
      flash[:notice] = 'Transaction created successfully!'
      category_transaction = CategoryTransactionItem.new
      category_transaction.category = @category
      category_transaction.transaction_item = @transaction_item
      if category_transaction.save
        @category.total_amount = TransactionItem.total_category_amount(@category, @user)
        if @category.update
          flash[:notice] =
            "Transaction created successfully! \\n Total amount for #{@category.name} category updated"
        else
          flash[:alert] = category_transaction.errors.full_messages.join(', ')
        end
      end
      redirect_to categories_path
    else
      flash[:alert] = @transaction_item.errors.full_messages.join(', ')
      redirect_to new_transaction_item_path, locals: { transaction_item: @transaction_item }
    end
  end

  private

  def transaction_item_params
    params.require(:new_transaction_item).permit(:name, :amount)
  end
end
