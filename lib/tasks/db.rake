namespace :db do
  task data: :environment do
    for i in 0..5 do
      puts "### Inserting the product and store number #{i} ###"
      Product.create!(name: Faker::App.name, brand: Faker::Company.name, price: rand(1.00...2000.00))
      Store.create!(name: Faker::Company.name, address: Faker::Address.street_address, city: Faker::Address.city, country: Faker::Address.country)
    end

    for i in 0..5 do
      puts "### Inserting the stock number #{i} ###"
      product = Product.offset(rand(Product.count)).first
      store = Store.offset(rand(Store.count)).first
    
      StockItem.create!(quantity: rand(1..100), product_id: product.id, store_id: store.id)
    end
  end
end
