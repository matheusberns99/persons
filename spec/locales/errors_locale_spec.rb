require 'rails_helper'

RSpec.describe 'Errors' do
  context 'errors' do
    context 'messages' do
      it 'register_not_found' do
        expect(I18n.t('errors.messages.register_not_found')).to eq 'Registro não encontrado'
      end
    end
  end
end
