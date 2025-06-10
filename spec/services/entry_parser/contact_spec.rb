# frozen_string_literal: true

require 'rails_helper'

describe EntryParser::Contact do
  subject(:call) { described_class.call(resource:, contact:) }

  let!(:resource) { create(:patient) }
  let(:contact) do
    { use: 'work', system: 'email', value: 'tim@timhortons.com' }
  end

  describe '.call' do
    it 'creates a new Contact record' do
      expect { call }.to change(Contact, :count).by(1)
    end

    it 'sets the correct attributes on the Contact record', :aggregate_failures do
      contact = call

      expect(contact.use).to eq('work')
      expect(contact.system).to eq('email')
      expect(contact.value).to eq('tim@timhortons.com')
    end

    context 'when the entry is invalid' do
      let(:contact) do
        {
          resource: {
            use: "mobile",
            system: "carrier_pigeon",
            value: "steve"
          }
        }
      end

      it 'raises an error' do
        expect { call }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
