require 'rails_helper'

RSpec.describe TokenValidationController, type: :request do
  describe 'GET #validate_token' do
    context 'when user is authenticated' do
      before do
        # Assuming you have a User model with a factory set up for testing
        @user = create(:user)
        @headers = @user.create_new_auth_token
        get '/validate_token', headers: @headers
      end

      it 'responds with HTTP 200 status code' do
        expect(response).to have_http_status(200)
      end

      it 'returns a valid JSON response with valid: true' do
        json_response = JSON.parse(response.body)
        expect(json_response['valid']).to eq(true)
      end
    end

    context 'when user is not authenticated' do
      it 'responds with HTTP 401 status code' do
        get '/validate_token'
        expect(response).to have_http_status(401)
      end
    end
  end
end