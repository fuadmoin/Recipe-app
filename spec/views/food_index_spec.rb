require 'rails_helper'

RSpec.describe 'foods/index', type: :view do
  let(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password', confirmed_at: Time.now) }

  before do
    assign(:foods, [
      Food.create(name: 'Food 1', measurement_unit: 'Unit 1', price: 10, quantity: 5, user: user),
      Food.create(name: 'Food 2', measurement_unit: 'Unit 2', price: 15, quantity: 3, user: user)
    ])
    assign(:user, user) # Assign the user variable
    render
  end

  it 'displays a list of foods' do
    expect(rendered).to have_selector('table.ingredient-table tr', count: 3) # Including the table header
  end

  it 'renders food details correctly' do
    expect(rendered).to have_selector('table.ingredient-table tr', text: 'Food 1')
    expect(rendered).to have_selector('table.ingredient-table tr', text: 'Unit 1')
    expect(rendered).to have_selector('table.ingredient-table tr', text: '$10')
    expect(rendered).to have_selector('table.ingredient-table tr', text: 'Food 2')
    expect(rendered).to have_selector('table.ingredient-table tr', text: 'Unit 2')
    expect(rendered).to have_selector('table.ingredient-table tr', text: '$15')
  end

  it 'renders a delete button for each food' do
    expect(rendered).to have_selector('table.ingredient-table tr td form[action^="/foods/"][method="post"]')
  end

  it 'renders a submit button for each delete form' do
    expect(rendered).to have_selector('table.ingredient-table tr td form[action^="/foods/"][method="post"] input[type="submit"][value="Delete"]')
  end
end
