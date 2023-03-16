# frozen_string_literal: true

module Api
  module V1
    module Admin
      class CombosController < BaseController
        before_action :set_combo, only: %i[show update destroy]

        def index
          @pagy, @combos = pagy(Combo.all)
        end

        def show; end

        def create
          @combo = Combo.new(combo_params)

          if @combo.save
            render :show
          else
            render_attributes_errors(@combo.errors)
          end
        end

        def update
          if @combo.update(combo_params)
            render :show
          else
            render_attributes_errors(@combo.errors)
          end
        end

        def destroy
          @combo.destroy

          head :no_content
        end

        private

        def combo_params
          params.require(:combo).permit(:item_id, :quantity).tap do |param|
            param[:item_id] = Item.decode_id(param[:item_id]) if param[:item_id]
          end
        end

        def set_combo
          @combo = Combo.find_by_hashid!(params[:id])
        end
      end
    end
  end
end
