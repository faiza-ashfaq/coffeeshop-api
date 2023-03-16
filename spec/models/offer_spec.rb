# == Schema Information
#
# Table name: offers
#
#  id         :bigint           not null, primary key
#  discount   :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  combo_id   :bigint           indexed
#  item_id    :bigint           not null, indexed
#
# Indexes
#
#  index_offers_on_combo_id  (combo_id)
#  index_offers_on_item_id   (item_id)
#
# Foreign Keys
#
#  fk_rails_...  (combo_id => combos.id)
#  fk_rails_...  (item_id => items.id)
#
require 'rails_helper'

RSpec.describe Offer, type: :model do
  subject(:offer) { create(:offer) }

  describe 'associations' do
    it { is_expected.to belong_to(:combo).optional }
    it { is_expected.to belong_to(:item) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:discount) }
    it { is_expected.to validate_numericality_of(:discount).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:discount).is_less_than(101) }
  end

  describe '.without_combo' do
    it 'returns offers without combos' do
      expect(described_class.without_combo).to include(offer)
    end

    it 'returns nothing if offers without combo does not exist' do
      offer.destroy

      expect(described_class.without_combo).to be_empty
    end
  end

  describe '#discounted_price' do
    it 'returns the calculated discount price' do
      offer.item.price = 0
      expect(offer.discounted_price).to eq(0)
    end
  end
end
