class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all.where(user: current_user)
  end

  def destroy
    recipe = Recipe.find(params[:id])
    flash[:notice] = "#{recipe.name} was successfully deleted"
    recipe.destroy
    redirect_to recipes_path
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(permitted_parameters_recipe)
    @recipe.user = current_user
    if @recipe.valid?
      @recipe.save
      redirect_to recipes_path, notice: "Recipe: #{@recipe.name} created successfully"
      return
    end
    redirect_to new_recipe_path
  end

  def show
    @recipe = Recipe.find(params[:id])
    @ingredients = @recipe.recipe_foods.includes(%i[recipe food])
    @recipes = Recipe.all
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.public = !@recipe.public
    @recipe.save
    @recipe.public
    render 'recipes/status_changed'
  end

  private

  def permitted_parameters_recipe
    params.require(:recipe).permit(:name, :description, :cookingTime,
                                   :preparationTime, :public)
  end
end
