class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :customer, foreign_key: true   # Order belongs to a customer
      t.references :shop, foreign_key: true       # Order belongs to a shop

      t.integer :status, default: 0, null: false

      t.decimal :subtotal, precision: 10, scale: 2
      t.decimal :total, precision: 10, scale: 2
      t.decimal :tax_total, precision: 10, scale: 2
      t.decimal :discount_total, precision: 10, scale: 2
      t.datetime :paid_at
      t.datetime :completed_at

      t.timestamps
    end
  end
end
