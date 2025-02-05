class CreateComboDiscounts < ActiveRecord::Migration[7.2]
  def change
    create_table :combo_discounts do |t|
      t.references :discount, foreign_key: true  # Link to the Discount
      t.references :item, foreign_key: true  # The item that is eligible for the combo
      t.integer :free_items_count, default: 1  # How many free items are given with the combo
      t.timestamps
    end
  end
end
