require 'rails_helper'

RSpec.describe 'Public recipes page test', type: :feature do
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
  end

  after :all do
    @public_recipe.destroy
    @private_recipe.destroy
    @user.destroy
  end
  before :each do
    sign_in @user
    visit root_path
  end

  it 'The page title should be visible.' do
    expect(page).to have_content('Public Recipes')
  end
  it 'The public recipe should be visible' do
    expect(page.has_link?('Huevos a la mexicana')).to be true
  end
  it 'The private recipe should not be present' do
    expect(page.has_link?('Enchiladas')).to be false
  end
  it "When click on a recipe, it redirects to that recipe's details page" do
    find_link(href: recipe_path(id: @public_recipe.id)).click
    expect(page).to have_content("Preparation time: #{@public_recipe.preparationTime} minutes")
  end
end
