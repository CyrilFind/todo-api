require 'rails_helper'

RSpec.describe 'Tasks API' do
  let!(:user) { FactoryBot.create(:user) }
  let(:headers) { headers_from_login(user) }
  let!(:tasks) { FactoryBot.create_list(:task, 20, user: user) }
  let(:id) { tasks.first.id }
  let(:valid_attributes) { { task: { title: "New Task" } } }
  let(:invalid_attributes) { { task: { description: "Failing Task", done: true, due_date: "string" } } }

  describe 'GET /tasks' do
    before { get "/tasks", headers: headers  }

    context 'when user is logged in' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all tasks' do
        expect(json_response.size).to eq(20)
      end
    end

    context "when other user is logged in" do
      it 'returns no tasks' do
        other_user = FactoryBot.create(:user)
        get "/tasks", headers: headers_from_login(other_user)
        expect(json_response.size).to eq(0)
      end
    end

    context 'when user is not logged in' do
      let!(:headers) { {} }

      it 'returns status code 404' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'GET /tasks/:id' do
    before { get "/tasks/#{id}", headers: headers  }

    context 'when task exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the task' do
        expect(json_response[:id]).to eq(id)
      end
    end

    context 'when task does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Task/)
      end
    end
  end

  describe 'POST /tasks' do
    context 'when request attributes are valid' do
      before { post "/tasks", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/tasks", params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Title can't be blank/)
      end
    end
  end

  describe 'PUT /tasks/:id' do
    before { put "/tasks/#{id}", params: valid_attributes, headers: headers }

    context 'when task exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'updates the task' do
        updated_task = Task.find(id)
        expect(updated_task.title).to match(/New Task/)
      end
    end

    context 'when the task does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Task/)
      end
    end
  end

  # Test suite for DELETE /todos/:id
  describe 'DELETE /task/:id' do
    before { delete "/tasks/#{id}", headers: headers }

    context 'when task exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'destroys the task' do
        expect { Task.find(id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when the task does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Task/)
      end
    end
  end
end
