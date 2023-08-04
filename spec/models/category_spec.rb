require 'rails_helper'

RSpec.describe Category, type: :model do

  it 'has a valid factory' do
    expect(build(:category)).to be_valid
  end

  it 'is not valid without a name' do
    category = build(:category, name: nil)
    expect(category).not_to be_valid
  end

  it 'validates uniqueness of name within the scope of user_id' do
    user = create(:user)
    create(:category, name: 'Groceries', user: user)
    
    category = build(:category, name: 'Groceries', user: user)
    expect(category).not_to be_valid
  end

  it 'is valid with a unique name within the scope of user_id' do
    user = create(:user)
    create(:category, name: 'Groceries', user: user)

    category = build(:category, name: 'Shopping', user: user)
    expect(category).to be_valid
  end

end
