# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Filterable, type: :module do
  let!(:matching_record) { create(:person, name: 'Matheus Berns') }
  let!(:non_matching_record) { create(:person, name: 'Joao da silva') }

  describe '.apply_filter' do
    context 'when a valid filter is applied' do
      it 'returns filtered results' do
        result = Person.apply_filter(name: 'matheus berns')
        expect(result).to include(matching_record)
      end
    end

    context 'when an invalid filter is applied' do
      it 'ignores the invalid filter and returns all records' do
        result = Person.apply_filter(invalid_filter: 'value')
        expect(result).to include(matching_record, non_matching_record)
      end
    end
  end
end
