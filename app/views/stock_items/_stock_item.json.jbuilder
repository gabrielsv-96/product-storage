json.extract! stock_item, :id, :quantity, :created_at, :updated_at
json.url stock_item_url(stock_item, format: :json)