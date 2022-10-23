require 'rails_helper'

RSpec.describe 'Recipe Food model', type: :request do
  before :all do
    @user = User.create(name: 'Victor', email: 'victorperaltagomez@gmail.com', password: '121212')
    @food = Food.new(name: 'Bread', measurementUnit: 'Piece', price: 1.00, user: @user)
    @recipe = Recipe.new(name: 'Huevos a la mexicana', description: 'The healthy choice', user: @user)
  end
  after :all do
    @user.destroy
  end
  it 'Create a valid recipe food' do
    recipe_food = RecipeFood.new(food: @food, quantity: 10, recipe: @recipe)
    expect(recipe_food).to be_valid
  end
  it 'Create an invalid recipe food due to invalid quantity' do
    recipe_food = RecipeFood.new(food: @food, quantity: -1, recipe: @recipe)
    expect(recipe_food).to be_invalid
    expect(recipe_food.errors[:quantity][0]).to be == 'Quantity must be greater than 0'
  end
  it 'Create an invalid recipe food due to quantity not provided' do
    recipe_food = RecipeFood.new(food: @food, recipe: @recipe)
    expect(recipe_food).to be_invalid
    expect(recipe_food.errors[:quantity][0]).to be == "Quantity can't be null"
  end
end
