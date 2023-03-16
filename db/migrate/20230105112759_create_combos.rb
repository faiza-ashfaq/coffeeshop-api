class CreateCombos < ActiveRecord::Migration[6.1]
  def change
    create_table :combos do |t|
      t.boolean :active, null: false, default: true
      t.integer :quantity, null: false, default: 0

      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
