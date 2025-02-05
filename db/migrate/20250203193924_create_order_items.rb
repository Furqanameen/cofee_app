class CreateOrderItems < ActiveRecord::Migration[7.2]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :unit_price
      t.decimal :tax_rate
      t.decimal :total_price

      t.timestamps
    end
  end
end
