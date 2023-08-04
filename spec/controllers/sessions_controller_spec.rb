require 'rails_helper'

RSpec.describe DeviseTokenAuth::SessionsController, type: :request do
  let(:user) { create(:user, password: 'password') }

  describe 'POST /auth/sign_in' do
    it 'returns a success response with authentication tokens' do
      post '/auth/sign_in', params: {
        email: user.email,
        password: 'password'
      }

      expect(response).to have_http_status(:success)

      expect(response.headers['access-token']).not_to be_nil
      expect(response.headers['client']).not_to be_nil
      expect(response.headers['uid']).to eq(user.email)
    end

    it 'returns unauthorized for invalid credentials' do
      post '/auth/sign_in', params: {
        email: user.email,
        password: 'wrong_password'
      }

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'DELETE /auth/sign_out' do
    it 'returns success when signed out' do
      post '/auth/sign_in', params: {
        email: user.email,
        password: 'password'
      }
      headers = {
        'uid' => response.headers['uid'],
        'client' => response.headers['client'],
        'access-token' => response.headers['access-token']
      }

      delete '/auth/sign_out', headers: headers

      expect(response).to have_http_status(:success)
    end

    it 'returns unauthorized when not signed in' do
      delete '/auth/sign_out'

      expect(response).to have_http_status(:not_found)
    end
  end
end
