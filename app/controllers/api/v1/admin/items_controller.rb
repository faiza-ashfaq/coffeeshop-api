# frozen_string_literal: true

module Api
  module V1
    module Admin
      class ItemsController < BaseController
        before_action :set_item, only: %i[show update destroy]

        def index
          @pagy, @items = pagy(Item.all)
        end

        def show; end

        def create
          @item = Item.new(item_params)

          if @item.save
            render :show
          else
            render_attributes_errors(@item.errors)
          end
        end

        def update
          if @item.update(item_params)
            render :show
          else
            render_attributes_errors(@item.errors)
          end
        end

        def destroy
          @item.destroy

          head :no_content
        end

        private

        def item_params
          params.require(:item).permit(:title, :price, :tax_rate, :item_image, :description)
        end

        def set_item
          @item = Item.find_by_hashid!(params[:id])
        end
      end
    end
  end
end
