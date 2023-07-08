require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.create(name: 'Test User') }

  it 'validates presence of name' do
    recipe = Recipe.new(user:, name: '')
    expect(recipe).to_not be_valid
    expect(recipe.errors[:name]).to include("can't be blank")
  end

  it 'validates that preparation_time is greater than or equal to 0' do
    recipe = Recipe.new(user:, name: 'Test Recipe', preparation_time: -1)
    expect(recipe).to_not be_valid
    expect(recipe.errors[:preparation_time]).to include('must be greater than or equal to 0')
  end

  it 'validates that cooking_time is greater than or equal to 0' do
    recipe = Recipe.new(user:, name: 'Test Recipe', cooking_time: -1)
    expect(recipe).to_not be_valid
    expect(recipe.errors[:cooking_time]).to include('must be greater than or equal to 0')
  end
end
