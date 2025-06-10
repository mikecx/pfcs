# frozen_string_literal: true

require 'rails_helper'

describe EntryParser::Doctor do
  subject(:call) { described_class.call(resource:) }

  let(:resource) do
    {
      id: 'Doctor/123',
      name: [
        {
          family: 'Doe',
          given: %w[John A.]
        }
      ]
    }
  end

  describe '#call' do
    it 'creates or updates a doctor with the provided resource data', :aggregate_failures do
      expect { call }.to change { Doctor.count }.by(1)

      doctor = Doctor.last
      expect(doctor.resource_id).to eq('Doctor/123')
      expect(doctor.name).to eq('John A. Doe')
    end
  end
end
