class CreateShops < ActiveRecord::Migration[7.2]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :region
      t.decimal :tax_rate

      t.timestamps
    end
  end
end
