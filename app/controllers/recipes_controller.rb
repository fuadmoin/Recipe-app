class RecipesController < ApplicationController
    before_action :authenticate_user!, only: %i[index]

    def index
        @recipes = Recipe.all
        @user = current_user
    end

    def show
        @recipe = Recipe.find(params[:id])
        @user = current_user
        @foods = @user.foods.where.not(id: @recipe.foods)
    end

    def create 
        @user = current_user
        @recipe = @user.recipes.build(post_params)

        if @recipe.save
            redirect_to @recipe
        else
            render 'new'
        end
    end

    def update_public_status
        @recipe = Recipe.find(params[:id])
        @recipe.update(public: !@recipe.public)
        redirect_to @recipe
    end

    def public_recipes
        @recipes = Recipe.where(public: true)
    end

    def general_shopping_list
        @recipe = Recipe.find(params[:id])
    end

    def destroy
        @recipe = Recipe.find(params[:id])
        @recipe.destroy
        redirect_to recipes_path, notice: 'Recipe was successfully destroyed'
    end

    private

  def post_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end

end