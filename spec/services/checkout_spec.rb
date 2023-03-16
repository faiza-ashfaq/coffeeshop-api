require 'rails_helper'

RSpec.describe Checkout do
  describe '#call' do
    let(:item) { create(:item) }
    let(:user) { create(:user) }
    let(:cart) { create(:cart, user: user) }

    context 'when cart is not empty' do
      before do
        create(:offer, item: item, discount: 10)
        create(:cart_item, cart: cart, item: item)
      end

      it 'creates order' do
        described_class.call(cart, user)

        expect(Order.count).to eq 1
      end
    end

    context 'when cart is empty' do
      it 'does not create order' do
        described_class.call(cart, user)

        expect(Order.count).to eq 0
      end
    end
  end
end
