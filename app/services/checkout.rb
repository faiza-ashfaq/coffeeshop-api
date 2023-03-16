class Checkout < ApplicationService
  attr_reader :current_cart, :user

  def initialize(current_cart, user)
    @current_cart = current_cart
    @user = user
  end

  def call
    ActiveRecord::Base.transaction do
      @order = user.orders.create(
        discount: discount,
        sub_total: current_cart.sub_total,
        total: total,
        order_items: current_cart.cart_items,
        order_status: :processing
      )
      
      current_cart.cart_items.update_all(cart_id: nil)
    end

    OrderMailer.order_completed(user, @order).deliver_later(wait: 30.minutes) if @order.valid?

    @order
  end

  private

  def discount
    @discount ||= DiscountCalculation.call(@current_cart, @current_cart.items)
  end

  def total
    @total ||= current_cart.sub_total - discount
  end
end
