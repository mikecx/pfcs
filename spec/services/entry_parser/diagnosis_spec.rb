# frozen_string_literal: true

require 'rails_helper'

describe EntryParser::Diagnosis do
  subject(:call) { described_class.call(resource:) }

  let(:resource) do
    {
      id: 'Diagnosis/123',
      meta: { lastUpdated: '2023-10-01T12:00:00Z' },
      status: 'final',
      code: {
        coding: [ { system: 'http://hl7.org/fhir/sid/icd-10', name: 'Flu', code: "J11.1" } ]
      },
      appointment: { reference: 'Appointment/789' }
    }
  end

  describe '#call' do
    it 'creates or updates a diagnosis with the provided resource data', :aggregate_failures do
      expect { call }.to change { Diagnosis.count }.by(1)

      diagnosis = Diagnosis.last
      expect(diagnosis.resource_id).to eq('Diagnosis/123')
      expect(diagnosis.meta).to be_a_kind_of(Hash)
      expect(diagnosis.status).to eq('final')
      expect(diagnosis.coding).to be_a_kind_of(Array)
      expect(diagnosis.appointment_reference).to eq('Appointment/789')
    end
  end
end
