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

class CartItem < ApplicationRecord
  belongs_to :cart, optional: true
  belongs_to :item
  belongs_to :order, optional: true

  validates :item_id, uniqueness: { scope: :cart_id }
  validates :quantity, presence: true, numericality: { greater_than: 0 }

  def calculate_price
    item.taxed_price * quantity
  end
end
