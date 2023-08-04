require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  let(:user) { create(:user) }
  let(:category) { create(:category, user: user) }
  let(:auth_headers) { user.create_new_auth_token }

  describe 'POST #create' do
    it 'creates a new category for the authenticated user' do

      request.headers.merge!(auth_headers)


      new_category_params = { category: { name: 'New Category' } }

      post :create, params: new_category_params

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['name']).to eq('New Category')
      expect(Category.last.user).to eq(user)
    end

    it 'returns unprocessable entity when the category params are invalid' do

      request.headers.merge!(auth_headers)

      invalid_category_params = { category: { name: '' } }

      post :create, params: invalid_category_params


      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)).to have_key('errors')
    end

    it 'returns unauthorized when user is not signed in' do

      post :create


      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'PATCH #update' do
    it 'updates the attributes of a category' do

      request.headers.merge!(auth_headers)


      updated_category_params = { category: { name: 'Updated Category' } }


      patch :update, params: { id: category.id }.merge(updated_category_params)


      category.reload


      expect(response).to have_http_status(:success)
      expect(category.name).to eq('Updated Category')
    end

    it 'returns unprocessable entity when the category params are invalid' do

      request.headers.merge!(auth_headers)


      invalid_category_params = { category: { name: '' } }


      patch :update, params: { id: category.id }.merge(invalid_category_params)


      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)).to have_key('errors')
    end

    it 'returns unauthorized when user is not signed in' do

      patch :update, params: { id: category.id }


      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a category' do

      request.headers.merge!(auth_headers)

      delete :destroy, params: { id: category.id }

      expect(response).to have_http_status(:success)
      expect(Category.exists?(category.id)).to be_falsey
    end

    it 'returns unauthorized when user is not signed in' do
      delete :destroy, params: { id: category.id }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
