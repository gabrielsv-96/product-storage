json.id stock_item.id
json.quantity stock_item.quantity
json.created_at stock_item.created_at.strftime("%d/%m/%Y %H:%M")
json.updated_at stock_item.updated_at.strftime("%d/%m/%Y %H:%M")
json.product_info do
  json.product stock_item.product.name
  json.brand stock_item.product.brand
  json.price number_to_currency(stock_item.product.price, :unit => "R$ ", :separator => ",", :delimiter => ".")
  json.product_url product_url(stock_item.product, format: :json)
end
json.store_info do
  json.store_name stock_item.store.name
  json.store_address "#{
    stock_item.store.address + ', ' + 
    stock_item.store.try(:city) + ', ' + 
    stock_item.store.try(:country)
  }"
  json.product_url store_url(stock_item.store, format: :json)
end
