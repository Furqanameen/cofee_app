class CreateDiscounts < ActiveRecord::Migration[7.2]
  def change
    create_table :discounts do |t|
      t.string "name", null: false
      t.integer "discount_type", null: false, default: 0  # Change from string to integer
      t.decimal "value", precision: 5, scale: 2
      t.text "condition"

      t.timestamps
    end
  end
end
