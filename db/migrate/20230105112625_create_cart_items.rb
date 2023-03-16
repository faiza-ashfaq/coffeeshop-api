class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      t.integer :quantity, null: false, default: 0

      t.references :cart, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.references :order, foreign_key: true

      t.timestamps
    end
    add_index :cart_items, [:item_id, :cart_id], unique: true
  end
end
