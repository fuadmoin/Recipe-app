require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:user) { User.create(name: 'Test User') }

  it 'validates presence of name' do
    food = Food.new(user: user, name: '')
    expect(food).to_not be_valid
    expect(food.errors[:name]).to include("can't be blank")
  end

  it 'validates that price is greater than 0' do
    food = Food.new(user: user, name: 'Test Food', price: 0)
    expect(food).to_not be_valid
    expect(food.errors[:price]).to include('must be greater than 0')
  end

  it 'validates that quantity is greater than 0' do
    food = Food.new(user: user, name: 'Test Food', quantity: -1)
    expect(food).to_not be_valid
    expect(food.errors[:quantity]).to include('must be greater than 0')
  end
end
