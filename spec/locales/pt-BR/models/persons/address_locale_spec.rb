require 'rails_helper'

RSpec.describe Persons::Address do
  describe 'Translations' do
    context 'pt-BR' do
      it 'street' do
        expect(I18n.t('activerecord.attributes.address.street')).to eq('Rua')
      end

      it 'city' do
        expect(I18n.t('activerecord.attributes.address.city')).to eq('Cidade')
      end

      it 'state' do
        expect(I18n.t('activerecord.attributes.address.state')).to eq('Estado')
      end

      it 'country' do
        expect(I18n.t('activerecord.attributes.address.country')).to eq('País')
      end

      it 'postal_code' do
        expect(I18n.t('activerecord.attributes.address.postal_code')).to eq('CEP')
      end

      it 'active' do
        expect(I18n.t('activerecord.attributes.address.active')).to eq('Ativo')
      end

      it 'deleted_at' do
        expect(I18n.t('activerecord.attributes.address.deleted_at')).to eq('Deletado em')
      end

      it 'created_at' do
        expect(I18n.t('activerecord.attributes.address.created_at')).to eq('Criado em')
      end

      it 'updated_at' do
        expect(I18n.t('activerecord.attributes.address.updated_at')).to eq('Editado em')
      end
    end
  end
end
