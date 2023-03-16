module Api
  module V1
    class CartsController < ApiController
      before_action :billing_details
      before_action :set_items

      def show; end

      private

      def billing_details
        @billing_details = BillingDetails.new(current_cart)
      end

      def set_items
        @items = current_cart.cart_items
      end
    end
  end
end
