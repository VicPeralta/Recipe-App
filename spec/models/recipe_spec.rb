require 'rails_helper'

RSpec.describe 'Recipe model', type: :request do
  before :all do
    @user = User.new(name: 'Victor', email: 'victorperaltagomez@gmail.com', password: '121212')
  end
  it 'Create a valid recipe' do
    recipe = Recipe.new(name: 'Huevos a la mexicana', description: 'The healthy choice', user: @user)
    expect(recipe).to be_valid
  end
  it 'Create an invalid recipe due to invalid name' do
    recipe = Recipe.new(name: '', description: 'The healthy choice', user: @user)
    expect(recipe).to be_invalid
    expect(recipe.errors[:name][0]).to be == "Name can't be null"
  end
  it 'Create an invalid recipe due to invalid description' do
    recipe = Recipe.new(name: 'Huevos a la mexicana', description: '', user: @user)
    expect(recipe).to be_invalid
    expect(recipe.errors[:description][0]).to be == "Description can't be null"
  end
end
