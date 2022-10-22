class PublicRecipesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @users = User.all
    @recipes = Recipe.includes([:user]).where(public: true)
  end
end
