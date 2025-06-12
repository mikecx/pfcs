# frozen_string_literal: true

require 'rails_helper'

describe FeedbackResponse, type: :model do
  subject(:feedback_response) { create(:feedback_response) }

  it 'has a valid factory' do
    expect(feedback_response).to be_valid
  end

  describe 'Validations' do
    specify(:aggregate_failures) do
      expect(feedback_response).to validate_presence_of(:nps_score)
      expect(feedback_response).to validate_inclusion_of(:nps_score).in_range(1..10)
    end
  end

  describe 'Associations' do
    specify(:aggregate_failures) do
      expect(feedback_response).to belong_to(:appointment)

      expect(feedback_response).to have_one(:doctor).through(:appointment)
      expect(feedback_response).to have_one(:patient).through(:appointment)
      expect(feedback_response).to have_one(:diagnosis).through(:appointment)
    end
  end

  describe 'Methods' do
    describe '#feedback_document' do
      it 'returns a formatted feedback document' do
        expected_document = <<~FEEDBACK
          Overall doctor rating where 1 is bad and 10 is amazing: #{feedback_response.nps_score}

          Was the diagnosis management plan understood: #{feedback_response.management_understood}

          Feedback on the doctor's communication around the diagnosis management: #{feedback_response.management_feedback}

          Feedback on how the patient feels about the diagnosis: #{feedback_response.diagnosis_feedback}
        FEEDBACK

        expect(feedback_response.feedback_document).to eq(expected_document)
      end
    end

    describe '#ai_sentiment' do
      it 'calls the AI service with the correct prompt' do
        allow(::Ai::OpenAi::Responses).to receive(:call).and_return('Positive feedback')
        sentiment = feedback_response.ai_sentiment

        expect(sentiment).to eq('Positive feedback')
      end
    end

    describe '#ai_more_information' do
      let!(:diagnosis) { create(:diagnosis) }
      let!(:appointment) { create(:appointment, diagnosis: diagnosis) }

      let!(:feedback_response) { create(:feedback_response, appointment:) }

      it 'calls the AI service with the correct prompt' do
        allow(::Ai::OpenAi::Responses).to receive(:call).and_return('Additional information about the diagnosis')
        more_info = feedback_response.ai_more_information

        expect(more_info).to eq('Additional information about the diagnosis')
      end
    end

    describe '#ai_organizations_and_groups' do
      let!(:diagnosis) { create(:diagnosis) }
      let!(:appointment) { create(:appointment, diagnosis: diagnosis) }

      let!(:feedback_response) { create(:feedback_response, appointment:) }

      it 'calls the AI service with the correct prompt' do
        allow(::Ai::OpenAi::Responses).to receive(:call).and_return('List of relevant organizations')
        organizations = feedback_response.ai_organizations_and_groups

        expect(organizations).to eq('List of relevant organizations')
      end
    end

    describe '#process_feedback' do
      let!(:patient) { create(:patient) }
      let!(:doctor) { create(:doctor) }
      let!(:contact) { create(:contact, system: :email, value: 'timbits@timbits.com', resource: patient) }
      let!(:diagnosis) { create(:diagnosis) }
      let!(:appointment) { create(:appointment, diagnosis:, patient:, doctor:) }

      let!(:feedback_response) { create(:feedback_response, appointment:) }

      it 'sends a feedback follow-up email' do
        allow(PatientsMailer).to receive_message_chain(:feedback_followup, :deliver_later)

        feedback_response.process_feedback

        expect(PatientsMailer).to have_received(:feedback_followup).with(feedback_response:)
      end
    end
  end
end
