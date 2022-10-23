require 'rails_helper'

RSpec.describe 'Shopping list page test', type: :feature do
  before :all do
    @user ||= User.create(
      name: 'Victor',
      email: 'victorperaltagomez@gmail.com',
      password: '121212'
    )
    @public_recipe = Recipe.create(
      name: 'Huevos a la mexicana',
      description: 'The healthy choice',
      user: @user, public: true
    )
    @private_recipe = Recipe.create(
      name: 'Enchiladas',
      description: 'Traditional mexican food',
      user: @user, public: false
    )
    @food1 = Food.create(name: 'Bread', measurementUnit: 'Piece', price: 1.00, user: @user)
    @food2 = Food.create(name: 'Egg', measurementUnit: 'Piece', price: 1.00, user: @user)
    @recipe_food1 = RecipeFood.create(food: @food1, quantity: 2, recipe: @public_recipe)
    @recipe_food2 = RecipeFood.create(food: @food2, quantity: 1, recipe: @public_recipe)
    @recipe_food3 = RecipeFood.create(food: @food1, quantity: 1, recipe: @private_recipe)
  end

  after :all do
    @recipe_food1.destroy
    @recipe_food2.destroy
    @recipe_food3.destroy
    @food1.destroy
    @food2.destroy
    @public_recipe.destroy
    @private_recipe.destroy
    @user.destroy
  end
  before :each do
    sign_in @user
    visit shopping_list_index_path
  end

  it 'The page title should be visible.' do
    expect(page).to have_content('Shopping List')
  end

  it 'The ingredients needed should be visible.' do
    expect(page).to have_content(@food1.name) && have_content(@food2.name)
  end
end
