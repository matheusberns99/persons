require 'rails_helper'

RSpec.describe ::Persons::AddressesController, type: :controller do
  let!(:person) { create(:person) }
  let!(:address) { create(:address, person: person) }

  describe 'GET #index' do
    it 'returns a list of addresses' do
      get :index, params: { person_id: person.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['addresses']).not_to be_empty
    end
  end

  describe 'GET #show' do
    it 'returns the requested address' do
      get :show, params: { person_id: person.id, id: address.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['address']['id']).to eq(address.id)
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) { attributes_for(:address) }
    let(:invalid_attributes) { { street: '', city: '' } }

    it 'creates a new address with valid attributes' do
      expect {
        post :create, params: { person_id: person.id, address: valid_attributes }
      }.to change(Persons::Address, :count).by(1)
      expect(response).to have_http_status(:created)
    end

    it 'returns errors for invalid attributes' do
      post :create, params: { person_id: person.id, address: invalid_attributes }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors']).not_to be_empty
    end
  end

  describe 'PUT #update' do
    let(:new_attributes) { { street: 'Updated Street' } }
    let(:invalid_attributes) { { street: '', city: '' } }

    it 'updates the address' do
      patch :update, params: { person_id: person.id, id: address.id, address: new_attributes }
      address.reload
      expect(address.street).to eq('Updated Street')
      expect(response).to have_http_status(:ok)
    end

    it 'returns errors for invalid attributes' do
      patch :update, params: { person_id: person.id, id: address.id, address: invalid_attributes }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors']).not_to be_empty
    end
  end

  describe 'DELETE #destroy' do
    it 'marks the address as inactive' do
      delete :destroy, params: { person_id: person.id, id: address.id }
      address.reload
      expect(address.active).to be_falsey
      expect(address.deleted_at).not_to be_nil
      expect(response).to have_http_status(:ok)
    end

    it 'not found a record to destroy the address' do
      put :destroy, params: { person_id: person.id, id: 99999 }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'PUT #recover' do
    before { address.update(active: false, deleted_at: Time.current) }

    it 'reactivates the address' do
      put :recover, params: { person_id: person.id, id: address.id }
      address.reload
      expect(address.active).to be_truthy
      expect(address.deleted_at).to be_nil
      expect(response).to have_http_status(:ok)
    end

    it 'not found a record to reactivates the address' do
      put :recover, params: { person_id: person.id, id: 99999 }
      expect(response).to have_http_status(:not_found)
    end
  end
end