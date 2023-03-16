# == Schema Information
#
# Table name: items
#
#  id          :bigint           not null, primary key
#  description :text
#  price       :decimal(10, 2)   default(0.0), not null
#  tax_rate    :integer          default(0), not null
#  title       :string           default(""), not null, indexed
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_items_on_title  (title) UNIQUE
#
require 'rails_helper'

RSpec.describe Item, type: :model do
  subject(:item) { create(:item) }

  describe 'associations' do
    it { is_expected.to have_one_attached(:item_image) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }
    it { is_expected.to validate_presence_of(:tax_rate) }
    it { is_expected.to validate_numericality_of(:tax_rate).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:tax_rate).is_less_than(100) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_uniqueness_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_least(10) }
    it { is_expected.to validate_length_of(:title).is_at_most(150) }
    it { is_expected.to validate_length_of(:description).is_at_most(1000) }
  end

  describe '#taxed_price' do
    it 'returns the calculated tax price' do
      item.price = 0
      expect(item.taxed_price).to eq(0)
    end
  end
end
