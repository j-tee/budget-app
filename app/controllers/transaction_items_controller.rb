class TransactionItemsController < ApplicationController
  def index
    @transactions = CategoryTransactionItem.where(category_id: params[:category_id]).order(created_at: :desc).includes(:category,
                                                                                                                       :transaction_item)
  end

  def new
    @transaction_item = TransactionItem.new
    @category_id = (params[:category_id] unless params[:category_id].nil?)
    respond_to do |format|
      format.html { render :new, locals: { transaction_item: @transaction_item } }
    end
  end

  def create
    @category = Category.find(params[:category_id])
    @user = current_user
    @transaction_item = TransactionItem.new(params.require(:new_transaction_item).permit(:name, :amount))
    @transaction_item.user = @user
    if @transaction_item.save
      flash[:notice] = 'Transaction created successfully!'
      category_transaction = CategoryTransactionItem.new
      category_transaction.category_id = @category.id
      category_transaction.transaction_item_id = @transaction_item.id
      if category_transaction.save
        @category.total_amount = CategoryTransactionItem.total_category_amount(@category.id)
        if @category.update(total_amount:@category.total_amount)
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
