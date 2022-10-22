class RecipeFoodsController < ApplicationController
  def new
    recipe = Recipe.find(params[:recipe_id])
    @ingredient = recipe.recipe_foods.new
  end

  def destroy
    @ingredient = RecipeFood.find(params[:id])
    recipe = params[:recipe_id]
    @ingredient.destroy
    respond_to do |format|
      format.html { redirect_to recipe_path(id: recipe), status: 303 }
      format.turbo_stream { flash.now[:notice] = "Ingedient: #{@ingredient.food.name} deleted" }
    end
  end

  def create
    @ingredient = RecipeFood.new(permitted_parameters_ingredient)
    @recipe = Recipe.find(params[:recipe_id])
    @ingredient.recipe = @recipe
    if @ingredient.valid?
      @ingredient.save
      respond_to do |format|
        format.html { redirect_to recipe_path(@recipe), status: 303 }
        format.turbo_stream { flash.now[:notice] = "Ingredient  #{@ingredient.food.name} added successfully" }
      end
      return
    end
    redirect_to recipe_path(@recipe)
  end

  def edit
    @ingredient = RecipeFood.find(params[:id])
  end

  def update
    ingredient_id = params[:id]
    quantity = params[:recipe_food][:quantity]
    @ingredient = RecipeFood.find(ingredient_id)
    @ingredient.quantity = quantity
    if @ingredient.valid?
      @ingredient.save
      respond_to do |format|
        format.html { redirect_to recipe_path(id: @ingredient.recipe.id), status: 303 }
        format.turbo_stream { flash.now[:notice] = "Ingredient  #{@ingredient.food.name} updated successfully" }
      end
      return
    end
    redirect_to recipe_path(id: params[:recipe_id]), status: 303
  end

  private

  def permitted_parameters_ingredient
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end
