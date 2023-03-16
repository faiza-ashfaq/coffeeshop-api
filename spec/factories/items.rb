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
FactoryBot.define do
  factory :item do
    title { Faker::Commerce.unique.product_name }
    price { Faker::Commerce.price }
    tax_rate { Faker::Number.within(range: 1..30) }
    description { Faker::Commerce.product_name }
  end
end
