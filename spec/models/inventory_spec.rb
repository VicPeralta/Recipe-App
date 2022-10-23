require 'rails_helper'

RSpec.describe 'Inventory model', type: :request do
  before :all do
    @user = User.create(name: 'Victor', email: 'victorperaltagomez@gmail.com', password: '121212')
  end
  after :all do
    @user.destroy
  end
  it 'Create a valid inventory' do
    inventory = Inventory.create(user: @user, name: 'Victor inventory')
    expect(inventory).to be_valid
  end
  it 'Create an invalid inventory due to empty name' do
    inventory = Inventory.create(user: @user)
    expect(inventory).to be_invalid
    expect(inventory.errors[:name][0]).to be == "Name can't be null"
  end
end
