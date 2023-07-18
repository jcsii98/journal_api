require 'rails_helper'

RSpec.describe User, type: :model do
  it "creates a new user with valid attributes" do
    user = User.create(
      email: "sample@email.com",
      password: "password",
      password_confirmation: "password"
    )

    expect(User.count).to eq(1)
    expect(user.email).to eq("sample@email.com")
    expect(user.password).to eq("password")
  end

  it "does not save a user with invalid attributes" do
    user = User.create(
      email: "invalid_email",
      password: "password",
      password_confirmation: "passwor"
    )

    expect(User.count).to eq(0)
  end
  
  it "deletes a user" do
    user = User.create(
      email: "sample2@email.com",
      password: "password",
      password_confirmation: "password"
    )
    user.delete

    expect(User.count).to eq(0)
  end
  
end
