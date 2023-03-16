module Api
  module V1
    class ItemsController < ApiController
      skip_before_action :authenticate_user!

      def index
        @pagy, @items = pagy(Item.all)
      end

      def show
        @item = Item.find_by_hashid!(params[:id])
      end
    end
  end
end
