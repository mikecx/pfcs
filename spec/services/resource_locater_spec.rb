# frozen_string_literal: true

require 'rails_helper'

describe ResourceLocater do
  subject(:call) { described_class.call(id:) }

  describe 'invalid resource class' do
    let(:id) { 'InvalidResource/123' }

    it 'raises an ArgumentError' do
      expect { call }.to raise_error(ArgumentError, "Resource class not found for ID: #{id}")
    end
  end

  describe 'valid resource classes' do
    context 'when the resource exists' do
      describe 'Appointment' do
        let!(:appointment) { create(:appointment) }
        let(:id) { appointment.resource_id }

        it 'returns the appointment resource' do
          expect(call).to eq(appointment)
        end
      end

      describe 'Doctor' do
        let!(:doctor) { create(:doctor) }
        let(:id) { doctor.resource_id }

        it 'returns the doctor resource' do
          expect(call).to eq(doctor)
        end
      end

      describe 'Diagnosis' do
        let!(:diagnosis) { create(:diagnosis) }
        let(:id) { diagnosis.resource_id }

        it 'returns the diagnosis resource' do
          expect(call).to eq(diagnosis)
        end
      end

      describe 'Patient' do
        let!(:patient) { create(:patient) }
        let(:id) { patient.resource_id }

        it 'returns the patient resource' do
          expect(call).to eq(patient)
        end
      end
    end
  end
end
