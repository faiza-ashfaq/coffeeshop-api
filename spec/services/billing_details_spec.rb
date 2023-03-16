require 'rails_helper'

RSpec.describe BillingDetails do
  let(:item) { create(:item) }
  let(:user) { create(:user) }
  let(:cart) { create(:cart, user: user) }
  let(:offer) { build(:offer, item: item, discount: 10) }

  describe '#sub_total' do
    before do
      create(:cart_item, cart: cart, item: item, quantity: 1)
    end

    it 'returns sub-total of cart' do
      billing_details = described_class.new(cart)
      expect(billing_details.sub_total).to eq(item.taxed_price)
    end
  end

  describe '#discount' do
    before do
      offer.save
      create(:cart_item, cart: cart, item: item, quantity: 1)
    end

    it 'returns discount of cart' do
      billing_details = described_class.new(cart)
      expect(billing_details.discount).to eq(offer.discounted_price)
    end
  end

  describe '#total' do
    before do
      offer.save
      create(:cart_item, cart: cart, item: item, quantity: 1)
    end

    it 'returns total of cart' do
      billing_details = described_class.new(cart)
      expect(billing_details.total).to eq(item.taxed_price - offer.discounted_price)
    end
  end
end
