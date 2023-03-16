class BillingDetails < ApplicationService
  attr_reader :current_cart

  def initialize(current_cart)
    @current_cart = current_cart
  end

  def discount
    @discount ||= DiscountCalculation.call(current_cart, current_cart.cart_items)
  end

  def sub_total
    @sub_total ||= current_cart.sub_total
  end

  def total
    @total ||= sub_total - discount
  end
end
