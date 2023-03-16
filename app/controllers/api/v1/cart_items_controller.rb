# frozen_string_literal: true

module Api
  module V1
    class CartItemsController < ApiController
      before_action :set_item
      before_action :set_cart_item, only: %i[update destroy]

      def create
        @cart_item = current_cart.cart_items.build(quantity: 1, item_id: @item.id)

        if @cart_item.save
          render :show
        else
          render_attributes_errors(@cart_item.errors)
        end
      end

      def update
        case params[:action_type]
        when 'increment'
          return render_attributes_errors(@cart_item.errors) unless @cart_item.update(quantity: @cart_item.quantity + 1)
        when 'decrement'
          return render_attributes_errors(@cart_item.errors) unless @cart_item.update(quantity: @cart_item.quantity - 1)
        else
          render_errors(I18n.t('errors.cart_item.parameter_for_cart_item_update'),
                        :bad_request) and return
        end

        render :show
      end

      def destroy
        @cart_item.destroy

        head :no_content
      end

      private

      def set_cart_item
        @cart_item = CartItem.find_by!(item_id: @item.id, cart_id: current_cart.id)
      end

      def set_item
        @item = Item.find_by_hashid!(params[:item_id])
      end
    end
  end
end
