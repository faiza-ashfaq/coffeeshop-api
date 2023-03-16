require 'rails_helper'

RSpec.describe DiscountCalculation do
  describe '#call' do
    let(:item) { create(:item) }
    let(:user) { create(:user) }
    let(:cart) { create(:cart, user: user) }

    context 'without combo discounts' do
      before do
        create(:offer, item: item, discount: 10)
        create(:cart_item, cart: cart, item: item)
      end

      it 'returns discount of offer only' do
        discount = item.price * (10 / 100.0)

        expect(format('%.2f',
                      described_class.call(cart, cart.cart_items))).to eq(format('%.2f', discount))
      end
    end

    context 'with combo discounts' do
      before do
        combo = create(:combo)
        offer = create(:offer, combo: combo, item: item, discount: 10)
        create(:cart_item, cart: cart, item: combo.item, quantity: combo.quantity)
        create(:cart_item, cart: cart, item: offer.item)
      end

      it 'returns discount of combo offer' do
        discount = item.price * (10 / 100.0)

        expect(format('%.2f',
                      described_class.call(cart, cart.cart_items))).to eq(format('%.2f', discount))
      end
    end

    context 'with both combo and without combo discounts' do
      before do
        combo = create(:combo)
        offer = create(:offer, combo: combo, item: item, discount: 10)
        create(:cart_item, cart: cart, item: combo.item, quantity: combo.quantity)
        create(:cart_item, cart: cart, item: offer.item)
        create(:offer, item: item, discount: 5)
      end

      it 'returns discount of offer only' do
        combo_discount = item.price * (10 / 100.0)
        offer_discount = item.price * (5 / 100.0)
        discount = combo_discount + offer_discount

        expect(format('%.2f',
                      described_class.call(cart, cart.cart_items))).to eq(format('%.2f', discount))
      end
    end
  end
end
