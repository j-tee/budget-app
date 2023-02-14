# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can %i[indec], Category
    can %i[index], TransactionItem
    can %i[delete destroy], Category, user_id: user.id
    can %i[delete destroy], TransactionItem, user_id: user.id
  end
end
