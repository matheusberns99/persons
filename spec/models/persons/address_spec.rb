require 'rails_helper'

RSpec.describe Persons::Address, type: :model do
  let(:person) { create(:person) }
  let!(:address) { create(:address,
                          street: "Rua Blumenau",
                          city: "Indaial",
                          state: "Santa Catarina",
                          postal_code: 89053300,
                          country: "Brasil",
                          person_id: person.id) }

  # Scopes
  describe '.by_active' do
    context 'when address is found' do
      subject(:by_active) { described_class.by_active('true') }
      it { is_expected.to include(address) }
    end

    context 'when address is not found' do
      subject(:by_active) { described_class.by_active('false') }
      it { is_expected.to_not include(address) }
    end
  end

  describe '.by_street' do
    context 'when address is found' do
      subject(:by_street) { described_class.by_street('rua blumenau') }
      it { is_expected.to include(address) }
    end

    context 'when address is not found' do
      subject(:by_street) { described_class.by_street('avenida blumenau') }
      it { is_expected.to_not include(address) }
    end
  end

  describe '.by_state' do
    context 'when address is found' do
      subject(:by_state) { described_class.by_state('santa catarina') }
      it { is_expected.to include(address) }
    end

    context 'when address is not found' do
      subject(:by_state) { described_class.by_state('parana') }
      it { is_expected.to_not include(address) }
    end
  end

  describe '.by_city' do
    context 'when address is found' do
      subject(:by_city) { described_class.by_city('indaial') }
      it { is_expected.to include(address) }
    end

    context 'when address is not found' do
      subject(:by_city) { described_class.by_city('pomerode') }
      it { is_expected.to_not include(address) }
    end
  end

  describe '.by_postal_code' do
    context 'when address is found' do
      subject(:by_postal_code) { described_class.by_postal_code(89053300) }
      it { is_expected.to include(address) }
    end

    context 'when address is not found' do
      subject(:by_postal_code) { described_class.by_postal_code(89053301) }
      it { is_expected.to_not include(address) }
    end
  end

  describe '.by_country' do
    context 'when address is found' do
      subject(:by_country) { described_class.by_country('brasil') }
      it { is_expected.to include(address) }
    end

    context 'when address is not found' do
      subject(:by_country) { described_class.by_country('argentina') }
      it { is_expected.to_not include(address) }
    end
  end

  # Fields
  describe '.street' do
    it 'has database column' do
      should have_db_column(:street).of_type(:string)
    end

    it { should validate_presence_of(:street) }

    it 'saves new value when received' do
      address = described_class.new(street: 'Rua Jurema',
                                    state: "Santa Catarina",
                                    city: "Blumenau",
                                    postal_code: 89053300,
                                    country: "Brasil",
                                    person_id: person.id)
      address.save!

      expect(address.street).to eq 'Rua Jurema'
    end
  end

  describe '.state' do
    it 'has database column' do
      should have_db_column(:state).of_type(:string)
    end

    it { should validate_presence_of(:state) }

    it 'saves new value when received' do
      address = described_class.new(street: 'Rua Jurema',
                                    state: "Santa Catarina",
                                    city: "Blumenau",
                                    postal_code: 89053300,
                                    country: "Brasil",
                                    person_id: person.id)
      address.save!

      expect(address.state).to eq 'Santa Catarina'
    end
  end

  describe '.city' do
    it 'has database column' do
      should have_db_column(:city).of_type(:string)
    end

    it { should validate_presence_of(:city) }

    it 'saves new value when received' do
      address = described_class.new(street: 'Rua Jurema',
                                    state: "Santa Catarina",
                                    city: "Blumenau",
                                    postal_code: 89053300,
                                    country: "Brasil",
                                    person_id: person.id)
      address.save!

      expect(address.city).to eq 'Blumenau'
    end
  end

  describe '.postal_code' do
    it 'has database column' do
      should have_db_column(:postal_code).of_type(:integer)
    end

    it { should validate_presence_of(:postal_code) }

    it 'saves new value when received' do
      address = described_class.new(street: 'Rua Jurema',
                                    state: "Santa Catarina",
                                    city: "Blumenau",
                                    postal_code: 89053300,
                                    country: "Brasil",
                                    person_id: person.id)
      address.save!

      expect(address.postal_code).to eq 89053300
    end
  end

  describe '.country' do
    it 'has database column' do
      should have_db_column(:country).of_type(:string)
    end

    it { should validate_presence_of(:country) }

    it 'saves new value when received' do
      address = described_class.new(street: 'Rua Jurema',
                                    state: "Santa Catarina",
                                    city: "Blumenau",
                                    postal_code: 89053300,
                                    country: "Brasil",
                                    person_id: person.id)
      address.save!

      expect(address.country).to eq 'Brasil'
    end
  end

  describe '.person_id' do
    it 'has database column' do
      should have_db_column(:person_id).of_type(:integer)
    end

    it 'has belongs_to relation' do
      should belong_to(:person).class_name('::Person').inverse_of(:addresses).with_foreign_key(:person_id)
    end

    it 'saves new value when received' do
      address = described_class.new(street: 'Rua Jurema',
                                    state: "Santa Catarina",
                                    city: "Blumenau",
                                    postal_code: 89053300,
                                    country: "Brasil",
                                    person_id: person.id)
      address.save!

      expect(address.person_id).to eq person.id
    end
  end

  describe '.apply_filter' do
    it 'test by street of apply_filter' do
      result = Persons::Address.apply_filter(street: 'Rua Blumenau')
      expect(result).to include(address)
    end
  end
end
