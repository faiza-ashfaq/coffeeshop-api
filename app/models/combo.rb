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

class Combo < ApplicationRecord
  belongs_to :item
  has_one :offer, dependent: :destroy

  validates :active, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }
end
