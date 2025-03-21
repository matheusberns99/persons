require 'rails_helper'

RSpec.describe Person, type: :model do
  let!(:person) { create(:person,
                         name: "Joao da silva",
                         email: "joao@gmail.com",
                         phone: "47992853825",
                         birthdate: Date.today - 2) }

  # Scopes
  describe '.by_active' do
    context 'when person is found' do
      subject(:by_active) { described_class.by_active('true') }
      it { is_expected.to include(person) }
    end

    context 'when person is not found' do
      subject(:by_active) { described_class.by_active('false') }
      it { is_expected.to_not include(person) }
    end
  end

  describe '.by_name' do
    context 'when person is found' do
      subject(:by_name) { described_class.by_name('joao') }
      it { is_expected.to include(person) }
    end

    context 'when person is not found' do
      subject(:by_name) { described_class.by_name('Joao da silva pereira') }
      it { is_expected.to_not include(person) }
    end
  end

  describe '.by_email' do
    context 'when person is found' do
      subject(:by_email) { described_class.by_email('joao@gmail') }
      it { is_expected.to include(person) }
    end

    context 'when person is not found' do
      subject(:by_email) { described_class.by_email('gabriel@gmail') }
      it { is_expected.to_not include(person) }
    end
  end

  describe '.by_phone' do
    context 'when person is found' do
      subject(:by_phone) { described_class.by_phone('47992853825') }
      it { is_expected.to include(person) }
    end

    context 'when person is not found' do
      subject(:by_phone) { described_class.by_phone('47992853821') }
      it { is_expected.to_not include(person) }
    end
  end

  describe '.by_birthdate' do
    subject(:by_birthdate) { described_class.by_birthdate(start_date, end_date) }

    let(:start_date) { (Date.today - 3).to_s }
    let(:end_date) { Date.today.to_s }

    it { is_expected.to include(person) }

    context 'when birthdate is not in period' do
      let(:start_date) { (Date.today + 2).to_s }
      it { is_expected.not_to include(person) }
    end

    context 'when end_date is nil' do
      let(:end_date) { nil }
      it { is_expected.to include(person) }

      context 'and person is before start_date' do
        let!(:person) { create(:person, birthdate: Date.today - 8.days) }
        it { is_expected.not_to include(person) }
      end
    end

    context 'when start_date is nil' do
      let(:start_date) { nil }
      let(:end_date) { (Date.today - 1.day).to_s }

      it { is_expected.to include(person) }

      context 'and person is after end_date' do
        let!(:person) { create(:person, birthdate: Date.today) }
        it {
          is_expected.not_to include(person) }
      end
    end
  end

  # Fields
  describe '.name' do
    it 'has database column' do
      should have_db_column(:name).of_type(:string)
    end

    it { should validate_presence_of(:name) }

    it 'saves new value when received' do
      person = described_class.new(name: 'Joao Kleber',
                                   email: "email@valido.com",
                                   phone: "47992853824",
                                   birthdate: Date.yesterday)
      person.save!

      expect(person.name).to eq 'Joao Kleber'
    end
  end

  describe '.phone' do
    it 'has database column' do
      should have_db_column(:phone).of_type(:string)
    end

    it { should validate_presence_of(:phone) }

    it 'saves new value when received' do
      person = described_class.new(name: 'Joao Kleber',
                                   email: "email@valido.com",
                                   phone: "47992853824",
                                   birthdate: Date.yesterday)
      person.save!

      expect(person.phone).to eq '47992853824'
    end
  end

  describe '.email' do
    it 'has database column' do
      should have_db_column(:email).of_type(:string)
    end

    it { should validate_presence_of(:email) }

    it 'saves new value when received' do
      person = described_class.new(name: 'Joao Kleber',
                                   email: "email@valido.com",
                                   phone: "47992853824",
                                   birthdate: Date.yesterday)
      person.save!

      expect(person.email).to eq 'email@valido.com'
    end
  end

  describe '.birthdate_cannot_be_in_the_future' do
    context 'when birthdate is in the future' do
      let(:person) { build(:person, birthdate: Date.tomorrow) }

      it 'returns a error' do
        person.save

        expect(person.errors.full_messages).to include I18n.t('activerecord.errors.models.person.attributes.base.invalid_future_date')
      end
    end

    context 'when birthdate is not in the future' do
      let(:person) { build(:person, birthdate: Date.yesterday) }

      it 'does not return a error' do
        person.save

        expect(person.errors.full_messages).to be_empty
      end
    end
  end

  describe '.apply_filter' do
    it 'test the by_name of apply_filter' do
      result = Person.apply_filter(name: 'Joao da silva')
      expect(result).to include(person)
    end
  end
end
