require 'rails_helper'

RSpec.describe TasksController, type: :controller do

  let(:user) { create(:user) }
  let(:category) { create(:category, user: user) }
  let(:task) { create(:task, category: category) }
  let(:auth_headers) { user.create_new_auth_token }

  before do
    request.headers.merge!(auth_headers)
  end

  describe 'GET #index' do
    it 'returns a list of tasks for the specified category' do

      create_list(:task, 3, category: category)


      get :index, params: { category_id: category.id }


      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).length).to eq(3)
    end
  end

  describe 'GET #show' do
    it 'returns the details of a task' do
      get :show, params: { category_id: category.id, id: task.id }

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['name']).to eq(task.name)
    end
  end

  describe 'POST #create' do
    it 'creates a new task' do
      task_params = {
        name: 'Task 1',
        body: 'Description of Task 1',
        due_date: Date.current.to_s
      }

      post :create, params: { category_id: category.id, task: task_params }

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['name']).to eq('Task 1')
      expect(JSON.parse(response.body)['body']).to eq('Description of Task 1')
      expect(JSON.parse(response.body)['due_date']).to eq(Date.current.to_s)
    end
  end

    describe 'GET #due_today' do
        it 'returns tasks that are due today' do

        today_tasks = []
        3.times do |i|
            today_tasks << create(:task, category: category, due_date: Date.current, name: "Task #{i + 1}")
        end


        create(:task, category: category, due_date: Date.current + 1.day)

        get :due_today

        expect(response).to have_http_status(:success)
        response_body = JSON.parse(response.body)
        expect(response_body.length).to eq(3)
        expect(response_body.first['due_date']).to eq(Date.current.to_s)
        end
    end
end
