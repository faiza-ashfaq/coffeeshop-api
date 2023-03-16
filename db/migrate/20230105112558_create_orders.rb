class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.decimal :discount, precision: 10, scale: 2, default: 0.0
      t.decimal :total, precision: 10, scale: 2, default: 0.0
      t.decimal :sub_total, precision: 10, scale: 2, default: 0.0
      t.integer :order_status, null: false, default: 0

      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
