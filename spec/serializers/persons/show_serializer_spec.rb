require 'rails_helper'

RSpec.describe Persons::ShowSerializer do
  let(:person) do
    create(:person,
           name: 'Joao da silva',
           email: 'email@valido.com',
           phone: '123456789',
           birthdate: '1999-01-01',
           active: true,
           created_at: Time.current.iso8601,
           updated_at: Time.current.iso8601)
  end

  subject(:serialized_person) do
    ActiveModelSerializers::SerializableResource.new(person, serializer: described_class).as_json
  end

  describe 'id' do
    it 'returns the correct value' do
      expect(serialized_person[:id]).to eq person.id
    end
  end

  describe 'name' do
    it 'returns the correct value' do
      expect(serialized_person[:name]).to eq person.name
    end
  end

  describe 'email' do
    it 'returns the correct value' do
      expect(serialized_person[:email]).to eq person.email
    end
  end

  describe 'phone' do
    it 'returns the correct value' do
      expect(serialized_person[:phone]).to eq person.phone
    end
  end

  describe 'birthdate' do
    it 'returns the correct value' do
      expect(serialized_person[:birthdate]).to eq person.birthdate
    end
  end

  describe 'active' do
    it 'returns the correct value' do
      expect(serialized_person[:active]).to be person.active
    end
  end

  describe 'created_at' do
    it 'returns the correct value' do
      expect(serialized_person[:created_at].to_s).to eq person.created_at.iso8601
    end
  end

  describe 'updated_at' do
    it 'returns the correct value' do
      expect(serialized_person[:updated_at].to_s).to eq person.updated_at.iso8601
    end
  end
end
