# frozen_string_literal: true

require 'rails_helper'

describe Doctor, type: :model do
  subject(:doctor) { build(:doctor) }

  it 'has a valid factory' do
    expect(doctor).to be_valid
  end

  describe 'Validations' do
    subject(:doctor) { create(:doctor) }

    specify(:aggregate_failures) do
      expect(doctor).to validate_presence_of(:resource_id)
      expect(doctor).to validate_uniqueness_of(:resource_id)
    end
  end

  describe 'Associations' do
    specify(:aggregate_failures) do
      expect(doctor).to have_many(:appointments).with_foreign_key(:actor_reference).class_name('Appointment')
      expect(doctor).to have_many(:feedback_responses).through(:appointments)
    end
  end

  describe "Methods" do
    describe '#appointments' do
      let(:doctor) { create(:doctor) }
      let!(:appointment1) { create(:appointment, actor_reference: doctor.resource_id) }
      let!(:appointment2) { create(:appointment, actor_reference: doctor.resource_id) }
      let!(:other_appointment) { create(:appointment) }

      it 'returns appointments associated with the doctor' do
        expect(doctor.appointments).to contain_exactly(appointment1, appointment2)
      end

      it 'does not return appointments not associated with the doctor' do
        expect(doctor.appointments).not_to include(other_appointment)
      end
    end
  end
end
