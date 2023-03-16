# == Schema Information
#
# Table name: orders
#
#  id           :bigint           not null, primary key
#  discount     :decimal(10, 2)   default(0.0)
#  order_status :integer          default("pending"), not null
#  sub_total    :decimal(10, 2)   default(0.0)
#  total        :decimal(10, 2)   default(0.0)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null, indexed
#
# Indexes
#
#  index_orders_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Order, type: :model do
  subject(:order) { create(:order) }

  it {
    is_expected.to define_enum_for(:order_status).with_values(%i[pending processing completed])
  }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:order_items) }
  end

  describe 'validations' do
    it { is_expected.to validate_numericality_of(:discount).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_presence_of(:order_status) }
    it { is_expected.to validate_numericality_of(:sub_total).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:total).is_greater_than_or_equal_to(0) }
  end
end
