class CreateOffers < ActiveRecord::Migration[6.1]
  def change
    create_table :offers do |t|
      t.integer :discount, null: false, default: 0

      t.references :combo, foreign_key: true
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
