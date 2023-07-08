require 'rails_helper'

RSpec.describe 'recipes/public_recipes', type: :view do
  let(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password', confirmed_at: Time.now) }
  let(:recipe) { Recipe.create(name: 'Recipe 1', user:, preparation_time: 30, cooking_time: 45, public: true) }
  let(:food) { Food.create!(name: 'Food 1', user:, measurement_unit: 'grams', price: 2.5, quantity: 100) }
  let!(:food_recipe) { FoodRecipe.create!(recipe:, food:, quantity: 200) }

  before do
    assign(:recipes, [recipe])
    render
  end

  it 'displays the recipe name' do
    expect(rendered).to have_selector('h2', text: 'Recipe 1')
  end

  it 'displays the author' do
    expect(rendered).to have_selector('small.author', text: 'by Test User')
  end

  it 'displays the total food items' do
    expect(rendered).to have_selector('p', text: 'Total food items: 1')
  end

  it 'displays the total price' do
    expect(rendered).to have_selector('p', text: 'Total price: $500.0')
  end
end
