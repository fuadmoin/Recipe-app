class RecipesController < ApplicationController
    before_action :authenticate_user!, only: %i[index]

    def index
        @recipes = Recipe.all
        @user = current_user
    end

    def show
        @recipe = Recipe.find(params[:id])
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
    
    private

  def post_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end

end