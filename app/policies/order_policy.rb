class OrderPolicy < ApplicationPolicy
  attr_reader :user, :order

  def initialize(user, order)
    @user = user
    @order = order
  end

  def index
    user.present?
  end

  def create?
    order.user == user
  end

  def show?
    user == order.user
  end
end
