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
class Item < ApplicationRecord
  has_one_attached :item_image, dependent: :destroy

  validates :description, length: { maximum: 1000 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :tax_rate, presence: true, numericality: { greater_than: 0, less_than: 100 }
  validates :title, presence: true, uniqueness: true, length: { in: 10..150 }

  def taxed_price
    @taxed_price ||= price + (price * tax_rate / 100.0)
  end
end
