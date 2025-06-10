# frozen_string_literal: true

require 'rails_helper'

describe EntryParser::Patient do
  subject(:call) { described_class.call(resource:) }

  let(:resource) do
    {
      id: 'Patient/123',
      active: true,
      name: [
        {
          text: 'John A. Doe',
          family: 'Doe',
          given: %w[John A.]
        }
      ],
      contact: [ { system: 'phone', value: '123-867-5309', use: 'mobile' } ],
      gender: 'male',
      birthDate: '1980-01-01',
      address: [
        {
          use: 'home',
          line: [ '123 Main St', 'Apt 4B' ]
        }
      ]
    }
  end

  describe '#call' do
    it 'creates or updates a patient with the provided resource data', :aggregate_failures do
      expect { call }.to change { Patient.count }.by(1)

      patient = Patient.last
      expect(patient.resource_id).to eq('Patient/123')
      expect(patient.name).to eq('John A. Doe')
      expect(patient.birth_date).to eq(Date.parse('1980-01-01'))
      expect(patient.addresses.count).to eq(1)
      expect(patient.addresses.first.lines).to eq('123 Main St Apt 4B')
    end

    it 'creates a contact with the provided phone number', :aggregate_failures do
      expect { call }.to change { Contact.count }.by(1)

      contact = Patient.last.contacts.last
      expect(contact.system).to eq('phone')
      expect(contact.value).to eq('123-867-5309')
      expect(contact.use).to eq('mobile')
    end

    it 'creates an address with the provided address data', :aggregate_failures do
      expect { call }.to change { Address.count }.by(1)

      address = Patient.last.addresses.last
      expect(address.use).to eq('home')
      expect(address.lines).to eq('123 Main St Apt 4B')
    end
  end
end
