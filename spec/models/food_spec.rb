require 'rails_helper'

RSpec.describe 'Food model', type: :request do
  before :all do
    @user = User.new(name: 'Victor', email: 'victorperaltagomez@gmail.com', password: '121212')
  end
  it 'Create a valid food' do
    food = Food.new(name: 'Bread', measurementUnit: 'Piece', price: 1.00, user: @user)
    expect(food).to be_valid
  end
  it 'Create an invalid food due to invalid name' do
    food = Food.new(name: '', measurementUnit: 'Piece', price: 1.00, user: @user)
    expect(food).to be_invalid
    expect(food.errors[:name][0]).to be == "Name can't be null"
  end
  it 'Create an invalid food due to invalid Measurement unit' do
    food = Food.new(name: 'Bread', measurementUnit: '', price: 1.00, user: @user)
    expect(food).to be_invalid
    expect(food.errors[:measurementUnit][0]).to be == "Measurement unit can't be null"
  end
  it 'Create an invalid food due to invalid price' do
    food = Food.new(name: 'Bread', measurementUnit: 'Piece', price: 0, user: @user)
    expect(food).to be_invalid
    expect(food.errors[:price][0]).to be == 'Price must be greater than 0'
  end
  it 'Create an invalid food due to price not provided' do
    food = Food.new(name: 'Bread', measurementUnit: 'Piece', user: @user)
    expect(food).to be_invalid
    expect(food.errors[:price][0]).to be == 'Price must be greater than 0'
  end
end
