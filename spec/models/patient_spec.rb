# frozen_string_literal: true

require 'rails_helper'

describe Patient, type: :model do
  subject(:patient) { build(:patient) }

  it 'has a valid factory' do
    expect(patient).to be_valid
  end

  describe 'Validations' do
    subject(:patient) { create(:patient) }

    specify(:aggregate_failures) do
      expect(patient).to validate_presence_of(:resource_id)
      expect(patient).to validate_presence_of(:name)
      expect(patient).to validate_uniqueness_of(:resource_id)
    end
  end

  describe 'Associations' do
    specify(:aggregate_failures) do
      expect(patient).to have_many(:contacts).dependent(:destroy)
      expect(patient).to have_many(:addresses).dependent(:destroy)
      expect(patient).to have_many(:appointments).with_foreign_key(:subject_reference).dependent(:destroy)

      expect(patient).to have_many(:feedback_responses).through(:appointments)
    end
  end

  describe 'Methods' do
    describe '#appointments' do
      let(:patient) { create(:patient) }
      let!(:appointment1) { create(:appointment, subject_reference: patient.resource_id) }
      let!(:appointment2) { create(:appointment, subject_reference: patient.resource_id) }
      let!(:other_appointment) { create(:appointment) }

      it 'returns appointments associated with the patient' do
        expect(patient.appointments).to contain_exactly(appointment1, appointment2)
      end

      it 'does not return appointments not associated with the patient' do
        expect(patient.appointments).not_to include(other_appointment)
      end
    end
  end
end
