module ApplicationHelper
  def current_controller_text
    case params[:controller]
    when 'transaction_items'
      if @transactions&.any?
        @transactions.first.category.total_amount.present? ? "TRANSACTIONS - GHS#{@transactions.first.category.total_amount}" : 'TRANSACTIONS'
      else
        'NO TRANSACTIONS'
      end
    when 'categories'
      'CATEGORIES'
    else
      'The Budget App'
    end
  end
end
