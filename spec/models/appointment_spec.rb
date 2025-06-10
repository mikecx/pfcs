# frozen_string_literal: true

require 'rails_helper'

describe Appointment, type: :model do
  subject(:appointment) { build(:appointment) }

  it 'has a valid factory' do
    expect(appointment).to be_valid
  end

  describe 'Validations' do
    subject(:appointment) { create(:appointment) }

    specify(:aggregate_failures) do
      expect(appointment).to validate_presence_of(:resource_id)
      expect(appointment).to validate_uniqueness_of(:resource_id)

      expect(appointment).to validate_presence_of(:period_start)
      expect(appointment).to validate_presence_of(:period_end)
    end

    it 'validates that end time is after start time' do
      appointment.period_start = Time.current
      appointment.period_end = Time.current - 1.hour

      expect(appointment).not_to be_valid
      expect(appointment.errors[:period_end]).to include("must be after start time")
    end
  end

  describe 'Methods' do
    describe '#subject' do
      context 'when the subject reference is not set' do
        it 'returns nil' do
          appointment.subject_reference = nil

          expect(appointment.subject).to be_nil
        end
      end

      context 'when the subject reference is set' do
        let!(:patient) { create(:patient) }

        it 'returns the subject resource' do
          appointment.subject_reference = patient.resource_id

          expect(appointment.subject).to eq(patient)
        end
      end
    end

    describe '#actor' do
      let!(:doctor) { create(:doctor) }

      it 'returns the actor resource' do
        appointment.actor_reference = doctor.resource_id

        expect(appointment.actor).to eq(doctor)
      end
    end
  end
end
