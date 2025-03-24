require 'rails_helper'

RSpec.describe Users::IndexSerializer do
  let(:user) { create(:user, email: 'email@valido.com') }

  subject(:serialized_user) do
    ActiveModelSerializers::SerializableResource.new(user, serializer: described_class).as_json
  end

  describe 'id' do
    it 'returns the correct value' do
      expect(serialized_user[:id]).to eq user.id
    end
  end

  describe 'email' do
    it 'returns the correct value' do
      expect(serialized_user[:email]).to eq user.email
    end
  end
end
