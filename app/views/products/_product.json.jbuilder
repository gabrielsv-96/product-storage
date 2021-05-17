json.id product.id
json.name product.name
json.brand product.brand
json.price number_to_currency(product.price, :unit => "R$ ", :separator => ",", :delimiter => ".")
json.created_at product.created_at.strftime("%d/%m/%Y %H:%M")
json.updated_at product.updated_at.strftime("%d/%m/%Y %H:%M")
json.url product_url(product, format: :json)
