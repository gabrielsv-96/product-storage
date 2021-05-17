require 'rails_helper'

RSpec.describe Product, :type => :model do
  it 'should not be a valid product without a name' do
    product = Product.new(name: nil)
    expect(product).to_not be_valid
  end

  it 'should not be not a valid product without a price' do
    product = Product.new(name: 'Test Name', price: nil)
    expect(product).to_not be_valid
  end

  it 'should be a valid product with valid values' do
    product = Product.new(name: Faker::App.name, price: rand(1.00...2000.00))
    expect(product).to be_valid
  end
end
