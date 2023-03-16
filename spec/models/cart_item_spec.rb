# == Schema Information
#
# Table name: cart_items
#
#  id         :bigint           not null, primary key
#  quantity   :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cart_id    :bigint           indexed, indexed => [item_id]
#  item_id    :bigint           not null, indexed, indexed => [cart_id]
#  order_id   :bigint           indexed
#
# Indexes
#
#  index_cart_items_on_cart_id              (cart_id)
#  index_cart_items_on_item_id              (item_id)
#  index_cart_items_on_item_id_and_cart_id  (item_id,cart_id) UNIQUE
#  index_cart_items_on_order_id             (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (cart_id => carts.id)
#  fk_rails_...  (item_id => items.id)
#  fk_rails_...  (order_id => orders.id)
#
require 'rails_helper'

RSpec.describe CartItem, type: :model do
  subject(:cart_item) { create(:cart_item) }

  describe 'associations' do
    it { is_expected.to belong_to(:cart).optional }
    it { is_expected.to belong_to(:item) }
    it { is_expected.to belong_to(:order).optional }
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:item_id).scoped_to(:cart_id) }
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than(0) }
  end

  describe '#calculate_price' do
    it 'is expected to return calculated price of item in cart' do
      expect(cart_item.calculate_price).to eq(cart_item.item.taxed_price * cart_item.quantity)
    end
  end
end
