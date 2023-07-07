class FoodRecipesController < ApplicationController
    def create
        @foodrecipe = FoodRecipe.new(foodrecipe_params)
        @foodrecipe.recipe_id = params[:recipe_id]
        if @foodrecipe.save
            redirect_to recipe_path(params[:recipe_id])
        else
            @recipe = Recipe.find(params[:recipe_id])
            render 'recipes/show'
        end
    end

    def edit
        @food_recipe = FoodRecipe.find(params[:id])
    end

    def update
        @food_recipe = FoodRecipe.find(params[:id])
        if @food_recipe.update(foodrecipe_params)
          redirect_to recipe_path(@food_recipe.recipe_id)
        else
          render 'edit'
        end
    end

    def destroy
        @food_recipe = FoodRecipe.find(params[:id])
        @food_recipe.destroy
        redirect_to recipe_path(@food_recipe.recipe_id)
    end

  private

  def foodrecipe_params
    params.require(:food_recipe).permit(:food_id, :quantity)
  end
end