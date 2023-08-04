require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  let(:user_attributes) do
    {
      email: 'test@example.com',
      password: 'password',
      password_confirmation: 'password'
    }
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new user and returns authentication tokens in response headers' do
        post :create, params: user_attributes
        expect(response).to have_http_status(:success)

        # Check that the authentication token is included in the response headers
        expect(response.headers['access-token']).not_to be_nil
        expect(response.headers['token-type']).not_to be_nil
        expect(response.headers['client']).not_to be_nil
        expect(response.headers['expiry']).not_to be_nil
        expect(response.headers['uid']).to eq(user_attributes[:email])
        expect(response.headers['Authorization']).not_to be_nil
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new user' do
        invalid_params = user_attributes.merge(password_confirmation: 'wrong_password')
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

end
