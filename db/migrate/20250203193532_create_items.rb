class CreateItems < ActiveRecord::Migration[7.2]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.integer :quantity, default: 0
      t.timestamps
    end
  end
end
