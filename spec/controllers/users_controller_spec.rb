require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include Devise::Test::ControllerHelpers

  let!(:user) { create(:user) }

  describe 'GET #index' do
    context 'when user signed in' do
      it 'returns a list of users' do
        sign_in user

        get :index
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['users']).not_to be_empty
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
      it 'returns a user' do
        sign_in user

        get :show, params: { id: user.id }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['user']['id']).to eq(user.id)
      end
    end

    context 'when user not signed in' do
      it 'returns 401 code' do
        get :show, params: { id: user.id }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST #create' do
    let(:user_attributes) { attributes_for(:user) }
    let(:invalid_user_attributes) { { email: 'invalid' } }

    context 'when user signed in' do
      it 'creates a new user with success' do
        sign_in user

        expect { post :create, params: { user: user_attributes } }.to change(User, :count).by(1)
        expect(response).to have_http_status(:created)
      end

      it 'returns errors for invalid user' do
        sign_in user

        post :create, params: { user: invalid_user_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']).not_to be_empty
      end
    end

    context 'when user not signed in' do
      it 'returns 401 code' do
        post :create, params: { user: user_attributes }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PUT #update' do
    let(:update_attributes) { { email: Faker::Internet.email } }
    let(:invalid_user_attributes) { { email: nil } }

    context 'when user signed in' do
      it 'updates the user' do
        sign_in user

        patch :update, params: { id: user.id, user: update_attributes }
        user.reload
        expect(user.email).to eq update_attributes[:email]
        expect(response).to have_http_status(:ok)
      end

      it 'returns errors for invalid attributes' do
        sign_in user

        patch :update, params: { id: user.id, user: invalid_user_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']).not_to be_empty
      end
    end

    context 'when user not signed in' do
      it 'returns 401 code' do
        patch :update, params: { id: user.id, user: update_attributes }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when user signed in' do
      it 'destroy the user' do
        sign_in user

        delete :destroy, params: { id: user.id }
        expect(response).to have_http_status(:ok)
      end

      it 'not found the user record to destroy' do
        sign_in user

        put :destroy, params: { id: 99999 }
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when user not signed in' do
      it 'returns 401 code' do
        delete :destroy, params: { id: user.id }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
