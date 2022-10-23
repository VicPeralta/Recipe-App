require 'rails_helper'

RSpec.describe 'Inventory Food model', type: :request do
  before :all do
    @user = User.create(name: 'Victor', email: 'victorperaltagomez@gmail.com', password: '121212')
    @food = Food.new(name: 'Bread', measurementUnit: 'Piece', price: 1.00, user: @user)
    @inventory = Inventory.create(user: @user, name: 'Victor inventory')
  end
  after :all do
    @inventory.destroy
    @user.destroy
  end
  it 'Create a valid inventory food' do
    inventory_food = InventoryFood.new(food: @food, quantity: 10, inventory: @inventory)
    expect(inventory_food).to be_valid
  end
  it 'Create an invalid inventory food due to invalid quantity' do
    inventory_food = InventoryFood.new(food: @food, quantity: -1, inventory: @inventory)
    expect(inventory_food).to be_invalid
    expect(inventory_food.errors[:quantity][0]).to be == 'Quantity must be greater than 0'
  end
  it 'Create an invalid inventory food due to quantity not provided' do
    inventory_food = InventoryFood.new(food: @food, inventory: @inventory)
    expect(inventory_food).to be_invalid
    expect(inventory_food.errors[:quantity][0]).to be == "Quantity can't be null"
  end
end
