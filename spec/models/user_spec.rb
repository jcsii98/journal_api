require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  it 'is not valid without an email' do
    user = build(:user, email: nil)
    expect(user).not_to be_valid
  end

  it 'is not valid without a password' do
    user = build(:user, password: nil)
    expect(user).not_to be_valid
  end

  it 'sets the uid (email) before saving' do
    user = build(:user)
    user.save

    expect(user.uid).to eq(user.email)
  end

  it 'does not allow duplicate email (uid) for users' do
    existing_user = create(:user)
    new_user = build(:user, email: existing_user.email)

    expect(new_user).not_to be_valid
  end

end
