# == Schema Information
#
# Table name: combos
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
#  quantity   :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :bigint           not null, indexed
#
# Indexes
#
#  index_combos_on_item_id  (item_id)
#
# Foreign Keys
#
#  fk_rails_...  (item_id => items.id)
#
require 'rails_helper'

RSpec.describe Combo, type: :model do
  subject(:combo) { create(:combo) }

  describe 'associations' do
    it { is_expected.to belong_to(:item) }
    it { is_expected.to have_one(:offer) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:active) }
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than(0) }
  end
end
