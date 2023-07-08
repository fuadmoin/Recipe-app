class RecipesController < ApplicationController
  before_action :authenticate_user!, only: %i[index]

  def index
    @recipes = Recipe.all
    @user = current_user
  end
end
