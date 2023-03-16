class DiscountCalculation < ApplicationService
  attr_reader :current_cart, :items

  def initialize(current_cart, items)
    @current_cart = current_cart
    @items = items
  end

  def call
    offer_only_discount(applicable_offers) + combo_discount(applicable_combos)
  end

  private

  def offer_only_discount(offers)
    offers.reduce(0) do |sum, offer|
      sum + offer.discounted_price
    end
  end

  def combo_discount(combos)
    combos.reduce(0) do |sum, combo|
      sum + calculate_discount(combo.offer)
    end
  end

  def calculate_discount(offer)
    return 0 unless current_cart.items.include?(offer.item)

    offer.discounted_price
  end

  def applicable_combos
    Combo.where(item_id: items.pluck(:item_id), quantity: items.pluck(:quantity))
  end

  def applicable_offers
    Offer.without_combo.where(item_id: items.pluck(:item_id))
  end
end
