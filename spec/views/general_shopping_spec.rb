require 'rails_helper'
RSpec.describe 'recipes/general_shopping_list', type: :view do
  let(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password', confirmed_at: Time.now) }
  let(:recipe) { Recipe.create(name: 'Recipe 1', user:, preparation_time: 30, cooking_time: 45, public: false) }
  let(:food) { Food.create!(name: 'Food 1', user:, measurement_unit: 'grams', price: 2.5, quantity: 100) }
  let!(:food_recipe) { FoodRecipe.create!(recipe:, food:, quantity: 200) }
  before do
    assign(:recipe, recipe)
    render
  end
  it 'displays the recipe name' do
    expect(rendered).to have_selector('h2', text: 'Shopping List for Recipe 1')
  end
  it 'displays the food ingredients table' do
    expect(rendered).to have_selector('table.table')
    expect(rendered).to have_selector('th.food', text: 'Food')
    expect(rendered).to have_selector('th.value', text: 'Quantity')
    expect(rendered).to have_selector('th.value', text: 'Price')
    expect(rendered).to have_selector('td.first', text: 'Food 1')
    expect(rendered).to have_selector('td.second', text: '200')
    expect(rendered).to have_selector('td.first', text: '500.0')
  end
  it 'displays the total cost' do
    expect(rendered).to have_selector('p', text: 'Total cost: $500.0')
  end
  it 'displays the number of items to buy' do
    expect(rendered).to have_selector('p', text: 'Amounts of items to buy: 1')
  end
end
