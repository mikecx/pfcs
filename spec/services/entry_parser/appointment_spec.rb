# frozen_string_literal: true

require 'rails_helper'

describe EntryParser::Appointment do
  subject(:call) { described_class.call(resource:) }

  let(:period_start) { 23.hours.ago }
  let(:period_end) { 22.hours.ago }

  let(:resource) do
    {
      id: 'Appointment/123',
      status: 'scheduled',
      type: [ { text: 'Consultation' } ],
      subject: { reference: 'Patient/456' },
      actor: { reference: 'Doctor/789' },
      period: { start: period_start.to_s, end: period_end.to_s }
    }
  end

  describe '#call' do
    it 'creates or updates an appointment with the provided resource data', :aggregate_failures do
      expect { call }.to change { Appointment.count }.by(1)

      appointment = Appointment.last
      expect(appointment.resource_id).to eq('Appointment/123')
      expect(appointment.status).to eq('scheduled')
      expect(appointment.appointment_type).to eq('Consultation')
      expect(appointment.subject_reference).to eq('Patient/456')
      expect(appointment.actor_reference).to eq('Doctor/789')
      expect(appointment.period_start).to be_within(10.seconds).of(period_start)
      expect(appointment.period_end).to be_within(10.seconds).of(period_end)
    end
  end
end
