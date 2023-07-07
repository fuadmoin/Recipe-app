require 'rails_helper'

RSpec.describe User, type: :model do
  it 'validates presence of name' do
    user = User.new(name: '')
    expect(user).to_not be_valid
    expect(user.errors[:name]).to include("can't be blank")
  end
end

