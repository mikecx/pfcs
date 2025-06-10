# frozen_string_literal: true

require 'rails_helper'

describe EntryParser::Address do
  subject(:call) { described_class.call(resource:, address:) }

  let!(:resource) { create(:patient) }
  let(:address) do
    { use: 'home', line: [ '123 Main St', 'Apt 4B' ] }
  end

  describe '.call' do
    it 'creates a new Address record' do
      expect { call }.to change(Address, :count).by(1)
    end

    it 'sets the correct attributes on the Address record' do
      address = call

      expect(address.use).to eq('home')
      expect(address.lines).to eq('123 Main St Apt 4B')
    end

    context 'when the entry is invalid' do
      let(:address) do
        {
          resource: {
            use: "satellite",
            line: []
          }
        }
      end

      it 'raises an error' do
        expect { call }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
