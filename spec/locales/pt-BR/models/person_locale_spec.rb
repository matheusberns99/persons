require 'rails_helper'

RSpec.describe Person do
  describe 'Translations' do
    context 'pt-BR' do
      it 'deleted_at' do
        expect(I18n.t('activerecord.attributes.person.deleted_at')).to eq('Deletado em')
      end

      it 'created_at' do
        expect(I18n.t('activerecord.attributes.person.created_at')).to eq('Criado em')
      end

      it 'active' do
        expect(I18n.t('activerecord.attributes.person.active')).to eq('Ativo')
      end

      it 'updated_at' do
        expect(I18n.t('activerecord.attributes.person.updated_at')).to eq('Editado em')
      end

      it 'name' do
        expect(I18n.t('activerecord.attributes.person.name')).to eq('Nome')
      end

      it 'email' do
        expect(I18n.t('activerecord.attributes.person.email')).to eq('E-mail')
      end

      it 'phone' do
        expect(I18n.t('activerecord.attributes.person.phone')).to eq('Telefone')
      end

      it 'birthdate' do
        expect(I18n.t('activerecord.attributes.person.birthdate')).to eq('Data de nascimento')
      end

      context 'errors' do
        it 'invalid_future_date' do
          expect(I18n.t('activerecord.errors.models.person.attributes.base.invalid_future_date')).to eq('Data de nascimento não pode estar no futuro')
        end

        it 'invalid_email_format' do
          expect(I18n.t('activerecord.errors.models.person.attributes.base.invalid_email_format')).to eq('E-mail inválido')
        end
      end
    end
  end
end
