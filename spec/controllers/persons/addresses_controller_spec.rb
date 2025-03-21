require 'rails_helper'

RSpec.describe Persons::AddressesController, type: :controller do
  let!(:person) { create(:person) }
  let!(:address) { create(:address, person: person) }

  describe 'GET #index' do
    it 'returns all addresses for the person' do
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
    let(:address_attributes) { attributes_for(:address) }
    let(:address_invalid_attributes) { { street: nil } }

    it 'creates a new address successfully' do
      expect {
        post :create, params: { person_id: person.id, address: address_attributes }
      }.to change(Persons::Address, :count).by(1)

      expect(response).to have_http_status(:created)
    end

    it 'returns errors when trying to create an invalid address' do
      post :create, params: { person_id: person.id, address: address_invalid_attributes }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors']).not_to be_empty
    end
  end

  describe 'PUT #update' do
    let(:update_attributes) { { street: Faker::Name.name } }
    let(:address_invalid_attributes) { { street: nil } }

    it 'updates an address successfully' do
      patch :update, params: { person_id: person.id, id: address.id, address: update_attributes }
      address.reload

      expect(address.street).to eq update_attributes[:street]
      expect(response).to have_http_status(:ok)
    end

    it 'returns errors for invalid address update' do
      patch :update, params: { person_id: person.id, id: address.id, address: address_invalid_attributes }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors']).not_to be_empty
    end
  end

  describe 'DELETE #destroy' do
    it 'destroy the address' do
      delete :destroy, params: { person_id: person.id, id: address.id }
      address.reload

      expect(address.active).to be false
      expect(address.deleted_at).not_to be_nil
      expect(response).to have_http_status(:ok)
    end

    it 'not found the address record to destroy' do
      delete :destroy, params: { person_id: person.id, id: 99999 }

      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'PUT #recover' do
    before { address.update(active: false, deleted_at: Time.current) }

    it 'recover the address' do
      put :recover, params: { person_id: person.id, id: address.id }
      address.reload

      expect(address.active).to be true
      expect(address.deleted_at).to be_nil
      expect(response).to have_http_status(:ok)
    end

    it 'not found the address record to recover' do
      put :recover, params: { person_id: person.id, id: 99999 }

      expect(response).to have_http_status(:not_found)
    end
  end
end
