class FoodsController < ApplicationController
  before_action :authenticate_user!, only: %i[index]

  def index
    @user = current_user
    @foods = @user.foods.all
  end

  def create
    @user = current_user
    @food = @user.foods.build(post_params)

    if @food.save
      redirect_to @food
    else
      render 'new'
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to foods_path, notice: 'Food was successfully destroyed'
  end

  private

  def post_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
