require 'rails_helper'

RSpec.describe 'recipes/index', type: :view do
  let(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password', confirmed_at: Time.now) }

  before do
    assign(:user, user) # Assign the user variable
    assign(:recipes, [
             Recipe.create(name: 'Recipe 1', user:, preparation_time: 30, cooking_time: 45,
                           description: 'Description 1'),
             Recipe.create(name: 'Recipe 2', user:, preparation_time: 20, cooking_time: 60,
                           description: 'Description 2')
           ])
    render
  end

  it 'displays a list of recipes' do
    expect(rendered).to have_selector('.recipe-field', count: 4)
  end

  it 'renders the recipe details correctly' do
    expect(rendered).to have_selector('.card-body h2 a', text: 'Recipe 1')
    expect(rendered).to have_selector('.card-body p', text: 'Description 1')
    expect(rendered).to have_selector('.card-body h2 a', text: 'Recipe 2')
    expect(rendered).to have_selector('.card-body p', text: 'Description 2')
  end

  it 'renders a create recipe form' do
    expect(rendered).to have_selector('.recipe-container form[action^="/recipes"][method="post"]')
    expect(rendered).to have_selector('.recipe-container form input[name="recipe[name]"]')
    expect(rendered).to have_selector('.recipe-container form input[name="recipe[preparation_time]"]')
    expect(rendered).to have_selector('.recipe-container form input[name="recipe[cooking_time]"]')
    expect(rendered).to have_selector('.recipe-container form textarea[name="recipe[description]"]')
    expect(rendered).to have_selector('.recipe-container form input[name="recipe[public]"]')
    expect(rendered).to have_selector('.recipe-container form input[type="submit"][value="Create Recipe"]')
  end
end
