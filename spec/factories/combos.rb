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
FactoryBot.define do
  factory :combo do
    association :item, factory: :item

    active { true }
    quantity { Faker::Number.within(range: 1..30) }
  end
end
