require 'rails_helper'

RSpec.describe PersonsController, type: :controller do
  let!(:person) { create(:person) }

  describe 'GET #index' do
    it 'returns a list of persons' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['persons']).not_to be_empty
    end
  end

  describe 'GET #show' do
    it 'returns the requested person' do
      get :show, params: { id: person.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['person']['id']).to eq(person.id)
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) { attributes_for(:person) }
    let(:invalid_attributes) { { name: '', email: 'invalid' } }

    it 'creates a new person with valid attributes' do
      expect {
        post :create, params: { person: valid_attributes }
      }.to change(Person, :count).by(1)
      expect(response).to have_http_status(:created)
    end

    it 'returns errors for invalid attributes' do
      post :create, params: { person: invalid_attributes }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors']).not_to be_empty
    end
  end

  describe 'PUT #update' do
    let(:new_attributes) { { name: 'Updated Name' } }
    let(:invalid_attributes) { { name: '', email: 'invalid' } }

    it 'updates the person' do
      patch :update, params: { id: person.id, person: new_attributes }
      person.reload
      expect(person.name).to eq('Updated Name')
      expect(response).to have_http_status(:ok)
    end

    it 'returns errors for invalid attributes' do
      patch :update, params: { id: person.id, person: invalid_attributes }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors']).not_to be_empty
    end
  end

  describe 'DELETE #destroy' do
    it 'marks the person as inactive' do
      delete :destroy, params: { id: person.id }
      person.reload
      expect(person.active).to be_falsey
      expect(person.deleted_at).not_to be_nil
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT #recover' do
    before { person.update(active: false, deleted_at: Time.current) }

    it 'reactivates the person' do
      put :recover, params: { id: person.id }
      person.reload
      expect(person.active).to be_truthy
      expect(person.deleted_at).to be_nil
      expect(response).to have_http_status(:ok)
    end
  end
end
