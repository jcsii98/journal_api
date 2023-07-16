require 'rails_helper'

RSpec.describe User, type: :model do
  it "creates a new user with valid attributes" do
    expect {
      post :create, params: { user: { name: "John Doe", password: "password"}}
    }.to change(User, :count).by(1)
    expect(response).to have_http_status(:created)
    expect(response).to have_attributes(content_type: "application/json")
end
