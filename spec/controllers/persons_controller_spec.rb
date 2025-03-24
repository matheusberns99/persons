require 'rails_helper'

RSpec.describe PersonsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let!(:user) { create(:user) }
  let!(:person) { create(:person) }

  describe 'GET #index' do
    context 'when user signed in' do
      it 'returns a list of persons' do
        sign_in user

        get :index
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['persons']).not_to be_empty
      end
    end

    context 'when user not signed in' do
      it 'returns 401 code' do
        get :index
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET #show' do
    context 'when user signed in' do
      it 'returns a person' do
        sign_in user

        get :show, params: { id: person.id }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['person']['id']).to eq(person.id)
      end
    end

    context 'when user not signed in' do
      it 'returns 401 code' do
        get :show, params: { id: person.id }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST #create' do
    let(:person_attributes) { attributes_for(:person) }
    let(:invalid_person_attributes) { { name: '', email: 'invalid' } }

    context 'when user signed in' do
      it 'creates a new person with success' do
        sign_in user

        expect { post :create, params: { person: person_attributes } }.to change(Person, :count).by(1)
        expect(response).to have_http_status(:created)
      end

      it 'returns errors for invalid person' do
        sign_in user

        post :create, params: { person: invalid_person_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']).not_to be_empty
      end
    end

    context 'when user not signed in' do
      it 'returns 401 code' do
        post :create, params: { person: person_attributes }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PUT #update' do
    let(:update_attributes) { { name: Faker::Name.name } }
    let(:invalid_person_attributes) { { name: nil } }

    context 'when user signed in' do
      it 'updates the person' do
        sign_in user

        patch :update, params: { id: person.id, person: update_attributes }
        person.reload
        expect(person.name).to eq update_attributes[:name]
        expect(response).to have_http_status(:ok)
      end

      it 'returns errors for invalid attributes' do
        sign_in user

        patch :update, params: { id: person.id, person: invalid_person_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']).not_to be_empty
      end
    end

    context 'when user not signed in' do
      it 'returns 401 code' do
        patch :update, params: { id: person.id, person: update_attributes }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when user signed in' do
      it 'destroy the person' do
        sign_in user

        delete :destroy, params: { id: person.id }
        person.reload
        expect(person.active).to be false
        expect(person.deleted_at).not_to be_nil
        expect(response).to have_http_status(:ok)
      end

      it 'not found the person record to destroy' do
        sign_in user

        put :destroy, params: { id: 99999 }
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when user not signed in' do
      it 'returns 401 code' do
        delete :destroy, params: { id: person.id }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PUT #recover' do
    before { person.update(active: false, deleted_at: Time.current) }

    context 'when user signed in' do
      it 'recover the person' do
        sign_in user

        put :recover, params: { id: person.id }
        person.reload
        expect(person.active).to be true
        expect(person.deleted_at).to be_nil
        expect(response).to have_http_status(:ok)
      end

      it 'not found the person record to recover' do
        sign_in user

        put :recover, params: { id: 99999 }
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when user not signed in' do
      it 'returns 401 code' do
        put :recover, params: { id: person.id }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
