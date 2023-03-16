# frozen_string_literal: true

module Api
  module V1
    module Admin
      module Combos
        class OffersController < BaseController
          before_action :set_combo
          before_action :set_offer, only: %i[show update destroy]

          def show; end

          def create
            @offer = @combo.build_offer(offer_params)

            if @offer.save
              render :show
            else
              render_attributes_errors(@offer.errors)
            end
          end

          def update
            if @offer.update(offer_params)
              render :show
            else
              render_attributes_errors(@offer.errors)
            end
          end

          def destroy
            @offer.destroy

            head :no_content
          end

          private

          def offer_params
            params.require(:offer).permit(:item_id, :discount).tap do |param|
              param[:item_id] = Item.decode_id(param[:item_id]) if param[:item_id]
            end
          end

          def set_combo
            @combo = Combo.find_by_hashid!(params[:combo_id])
          end

          def set_offer
            @offer = @combo.offer
          end
        end
      end
    end
  end
end
