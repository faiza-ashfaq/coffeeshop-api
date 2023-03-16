module Api
  module V1
    class OrdersController < ApiController
      before_action :set_order, only: :show

      def index
        @pagy, @orders = pagy(current_user.orders)
      end

      def create
        unless current_cart.items.length.positive?
          render_errors(I18n.t('errors.order.cart_is_empty'),
                        :bad_request) and return
        end

        @order = Checkout.call(current_cart, current_user)
        authorize @order

        return render_attributes_errors(@order.errors) unless @order.valid?

        render :show
      end

      def show
        authorize @order
      end

      private

      def set_order
        @order = Order.find_by_hashid!(params[:id])
      end
    end
  end
end
