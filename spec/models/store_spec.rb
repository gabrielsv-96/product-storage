require 'rails_helper'

RSpec.describe Store, :type => :model do
  it 'should not be a valid store without a name' do
    store = Store.new(name: nil)
    expect(store).to_not be_valid
  end

  it 'should not be a valid store without a address' do
    store = Store.new(name: 'Test Name', address: nil)
    expect(store).to_not be_valid
  end

  it 'should be a valid store with valid values' do
    store = Store.new(name: Faker::App.name, address: Faker::Address.street_address)
    expect(store).to be_valid
  end
end
