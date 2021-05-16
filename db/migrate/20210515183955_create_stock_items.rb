class CreateStockItems < ActiveRecord::Migration[5.2]
  def change
    create_table :stock_items do |t|
      t.integer :quantity
      t.references :product
      t.references :store

      t.timestamps
    end
  end
end
