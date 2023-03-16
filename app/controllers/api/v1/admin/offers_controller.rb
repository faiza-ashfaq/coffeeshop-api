# frozen_string_literal: true

module Api
  module V1
    module Admin
      class OffersController < BaseController
        before_action :set_offer, only: %i[show update destroy]

        def index
          @pagy, @offers = pagy(Offer.without_combo)
        end

        def show; end

        def create
          @offer = Offer.new(offer_params)

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

        def set_offer
          @offer = Offer.find_by_hashid!(params[:id])
        end
      end
    end
  end
end
