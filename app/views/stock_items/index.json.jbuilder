json.stock_items do
  json.array! @stock_items, partial: "stock_items/stock_item", as: :stock_item
end
