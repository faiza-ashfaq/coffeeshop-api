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
class Offer < ApplicationRecord
  belongs_to :combo, optional: true
  belongs_to :item

  validates :discount, presence: true, numericality: { greater_than: 0, less_than: 101 }

  scope :without_combo, -> { where(combo: nil) }

  def discounted_price
    item.price * (discount / 100.0)
  end
end
