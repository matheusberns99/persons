require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user, email: "test@example.com") }

  # Scopes
  describe '.by_email' do
    context 'when user is found' do
      subject(:by_email) { described_class.by_email('test@example.com') }
      it { is_expected.to include(user) }
    end

    context 'when user is not found' do
      subject(:by_email) { described_class.by_email('random@example.com') }
      it { is_expected.to_not include(user) }
    end
  end

  # Fields
  describe '.email' do
    it 'has database column' do
      should have_db_column(:email).of_type(:string)
    end

    it { should validate_presence_of(:email) }

    it 'saves new value when received' do
      password = "Senha@123"
      user = described_class.new(email: "email@valido.com",
                                 password: password,
                                 password_confirmation: password)
      user.save!

      expect(user.email).to eq 'email@valido.com'
    end
  end
end
