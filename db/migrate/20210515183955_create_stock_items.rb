class CreateStockItems < ActiveRecord::Migration[5.2]
  def change
    create_table :stock_items do |t|
      t.integer :quantity, null: false
      t.references :product, null: false
      t.references :store, null: false

      t.timestamps
    end
  end
end
