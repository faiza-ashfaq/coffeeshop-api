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
FactoryBot.define do
  factory :offer do
    association :item, factory: :item

    discount { Faker::Number.within(range: 1..99) }

    trait :with_combo do
      association :combo, factory: :combo
    end
  end
end
