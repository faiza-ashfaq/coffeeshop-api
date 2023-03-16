class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.decimal :price, precision: 10, scale: 2, null: false, default: 0.0
      t.integer :tax_rate, null: false, default: 0
      t.string :title, null: false, default: '', index: { unique: true }
      t.text :description, null: false, default: ''

      t.timestamps
    end
  end
end
