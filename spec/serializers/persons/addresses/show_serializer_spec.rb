require 'rails_helper'

RSpec.describe Persons::Addresses::ShowSerializer do
  let(:address) do
    create(:address,
           street: 'Rua Exemplo',
           city: 'Cidade Exemplo',
           state: 'Estado Exemplo',
           country: 'Brasil',
           postal_code: '12345-678',
           active: true,
           created_at: Time.current.iso8601,
           updated_at: Time.current.iso8601)
  end

  subject(:serialized_address) do
    ActiveModelSerializers::SerializableResource.new(address, serializer: described_class).as_json
  end

  describe 'id' do
    it 'returns the correct value' do
      expect(serialized_address[:id]).to eq address.id
    end
  end

  describe 'street' do
    it 'returns the correct value' do
      expect(serialized_address[:street]).to eq address.street
    end
  end

  describe 'city' do
    it 'returns the correct value' do
      expect(serialized_address[:city]).to eq address.city
    end
  end

  describe 'state' do
    it 'returns the correct value' do
      expect(serialized_address[:state]).to eq address.state
    end
  end

  describe 'country' do
    it 'returns the correct value' do
      expect(serialized_address[:country]).to eq address.country
    end
  end

  describe 'postal_code' do
    it 'returns the correct value' do
      expect(serialized_address[:postal_code]).to eq address.postal_code
    end
  end

  describe 'active' do
    it 'returns the correct value' do
      expect(serialized_address[:active]).to be address.active
    end
  end

  describe 'created_at' do
    it 'returns the correct value' do
      expect(serialized_address[:created_at].to_s).to eq address.created_at.iso8601
    end
  end

  describe 'updated_at' do
    it 'returns the correct value' do
      expect(serialized_address[:updated_at].to_s).to eq address.updated_at.iso8601
    end
  end
end
