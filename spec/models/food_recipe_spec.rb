require 'rails_helper'

RSpec.describe FoodRecipe, type: :model do
  let(:food) { Food.create(name: 'Test Food') }
  let(:recipe) { Recipe.create(name: 'Test Recipe') }

  it 'validates that quantity is greater than 0' do
    food_recipe = FoodRecipe.new(food:, recipe:, quantity: 0)
    expect(food_recipe).to_not be_valid
    expect(food_recipe.errors[:quantity]).to include('must be greater than 0')
  end
end
