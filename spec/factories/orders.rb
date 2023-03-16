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
FactoryBot.define do
  factory :order do
    association :user, factory: :user

    discount { Faker::Number.within(range: 1..200) }
    sub_total { Faker::Number.within(range: 200..1000) }
    total { sub_total - discount }
    order_status { :pending }

    before(:create) do |order|
      order.order_items << create_list(:cart_item, 5)
    end
  end
end
