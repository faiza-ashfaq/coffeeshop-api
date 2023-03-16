# == Schema Information
#
# Table name: carts
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null, indexed
#
# Indexes
#
#  index_carts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Cart, type: :model do
  subject(:cart) { create(:cart) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:cart_items) }
    it { is_expected.to have_many(:items) }
  end

  describe '#sub_total' do
    it 'is expected to return total of all items in cart excluding discounts' do
      expect(cart.sub_total).to eq(cart.cart_items.sum(&:calculate_price))
    end
  end
end
