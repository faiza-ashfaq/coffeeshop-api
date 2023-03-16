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

class Order < ApplicationRecord
  enum order_status: {
    pending: 0,
    processing: 1,
    completed: 2
  }

  belongs_to :user
  has_many :order_items, dependent: :destroy, class_name: 'CartItem'

  validates :discount, numericality: { greater_than_or_equal_to: 0 }
  validates :order_status, presence: true
  validates :sub_total, numericality: { greater_than_or_equal_to: 0 }
  validates :total, numericality: { greater_than_or_equal_to: 0 }
  validate :order_items_existence

  def order_items_existence
    return if order_items.length.positive?

    errors.add(:order_items, I18n.t('errors.order.order_items_existence'))
  end
end
