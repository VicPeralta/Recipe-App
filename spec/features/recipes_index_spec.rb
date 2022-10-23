require 'rails_helper'

RSpec.describe 'Recipes page test', type: :feature do
  before :all do
    @user = User.create(
      name: 'Victor',
      email: 'victorperaltagomez@gmail.com',
      password: '121212'
    )
    @public_recipe = Recipe.create(
      name: 'Huevos a la mexicana',
      description: 'The healthy choice',
      preparationTime: 10,
      cookingTime: 10,
      user: @user, public: true
    )
    @private_recipe = Recipe.create(
      name: 'Enchiladas',
      description: 'Traditional mexican food',
      preparationTime: 20,
      cookingTime: 20,
      user: @user, public: false
    )
  end

  after :all do
    @public_recipe.destroy
    @private_recipe.destroy
    @user.destroy
  end
  before :each do
    sign_in @user
    visit recipes_path
  end

  it 'The Add new recipe button should be visible.' do
    expect(page.has_link?('Add new recipe')).to be true
  end

  it 'The recipes list should be visible' do
    expect(page).to have_selector('h3', text: @public_recipe.name) &&
                    have_selector('h3', text: @private_recipe.name)
  end

  it "When click on a recipe, it redirects to that recipe's details page" do
    find_link('See Details', href: recipe_path(id: @public_recipe.id)).click
    expect(page).to have_content("Preparation time: #{@public_recipe.preparationTime} minutes")
  end

  it 'Delete recipe when click on remove button' do
    expect(page.has_link?('See Details', href: recipe_path(@public_recipe.id))).to be true
    find_link('Remove', href: recipe_path(id: @public_recipe.id)).click
    expect(page.has_link?('See Details', href: recipe_path(@public_recipe.id))).to be false
  end
end
