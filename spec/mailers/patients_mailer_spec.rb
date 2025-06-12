# frozen_string_literal: true

require "rails_helper"

describe PatientsMailer, type: :mailer do
  describe "feedback_followup" do
    let(:mail) { PatientsMailer.feedback_followup(feedback_response:) }

    let!(:patient) { create(:patient) }
    let!(:doctor) { create(:doctor) }
    let!(:appointment) { create(:appointment, patient:, doctor:) }
    let!(:diagnosis) { create(:diagnosis, appointment:) }
    let!(:feedback_response) { create(:feedback_response, appointment:) }

    before do
      # allow(feedback_response).to receive(:patient).and_return(patient)
      # allow(feedback_response).to receive(:appointment).and_return(appointment)
      allow(feedback_response).to receive(:ai_sentiment).and_return("Positive feedback")
      allow(feedback_response).to receive(:ai_more_information).and_return("More information about the appointment")
      allow(feedback_response).to receive(:ai_organizations_and_groups).and_return("Organizations and groups related to the appointment")
    end

    context "when the patient has an email contact" do
      let!(:contact) { create(:contact, system: :email, value: 'timbits@timbits.com', resource: patient) }

      it "renders the headers" do
        expect(mail.subject).to eq("Appointment feedback follow-up")
        expect(mail.to).to eq([ contact.value ])
        expect(mail.from).to eq([ "from@example.com" ])
      end

      it "renders the body", :aggregate_failures do
        expect(mail.body.encoded).to include("Positive feedback")
        expect(mail.body.encoded).to include("More information about the appointment")
        expect(mail.body.encoded).to include("Organizations and groups related to the appointment")
      end
    end

    context "when the patient does not have an email contact" do
      it "does not send the email" do
        expect(mail.to).to be_nil
        expect(mail.subject).to be_nil
        expect(mail.body).to eq("")
      end
    end
  end
end
