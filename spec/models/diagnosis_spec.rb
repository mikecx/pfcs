# frozen_string_literal: true

require 'rails_helper'

describe Diagnosis, type: :model do
  subject(:diagnosis) { build(:diagnosis) }

  it 'has a valid factory' do
    expect(diagnosis).to be_valid
  end

  describe 'Validations' do
    subject(:diagnosis) { create(:diagnosis) }

    specify(:aggregate_failures) do
      expect(diagnosis).to validate_presence_of(:resource_id)
      expect(diagnosis).to validate_uniqueness_of(:resource_id)
    end
  end

  describe "Methods" do
    describe '#appointment' do
      context "when appointment_reference is not present" do
        it 'returns nil' do
          diagnosis.appointment_reference = nil

          expect(diagnosis.appointment).to be_nil
        end
      end

      context 'when appointment_reference is present' do
        let(:appointment) { create(:appointment) }

        it 'returns the appointment resource' do
          diagnosis.appointment_reference = appointment.resource_id

          expect(diagnosis.appointment).to eq(appointment)
        end
      end
    end
  end
end
