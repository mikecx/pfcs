# frozen_string_literal: true

require 'rails_helper'

describe "Appointments::FeedbackResponses", type: :request do
  let!(:doctor) { create(:doctor) }
  let!(:patient) { create(:patient) }
  let!(:appointment) { create(:appointment, actor_reference: doctor.resource_id, subject_reference: patient.resource_id) }
  let!(:diagnosis) { create(:diagnosis, appointment_reference: appointment.resource_id) }

  describe "GET /new" do
    it "returns http success" do
      get new_appointment_feedback_response_path(appointment_id: appointment.id)

      expect(response).to have_http_status(:success)
    end

    it "renders the new template" do
      get new_appointment_feedback_response_path(appointment_id: appointment.id)

      expect(response).to render_template(:new)
    end

    it "assigns a new FeedbackResponse" do
      get new_appointment_feedback_response_path(appointment_id: appointment.id)

      expect(assigns(:feedback_response)).to be_a_new(FeedbackResponse)
      expect(assigns(:appointment)).to eq(appointment)
    end
  end

  describe "POST /create" do
    let(:params) do
      {
        feedback_response: {
          nps_score: 5,
          management_understood: true,
          management_feedback: "Great service!",
          diagnosis_feedback: "Very clear explanation."
        }
      }
    end

    it "returns http success" do
      post appointment_feedback_responses_path(appointment_id: appointment.id), params: params

      expect(response).to redirect_to(appointment_feedback_response_path(appointment.id, FeedbackResponse.last.id))
    end

    it "creates a new FeedbackResponse" do
      expect {
        post appointment_feedback_responses_path(appointment_id: appointment.id), params: params
      }.to change(FeedbackResponse, :count).by(1)
    end
  end

  describe "GET /show" do
    let!(:feedback_response) { create(:feedback_response, appointment: appointment) }

    it "returns http success" do
      get appointment_feedback_response_path(appointment_id: appointment.id, id: feedback_response.id)

      expect(response).to have_http_status(:success)
    end

    it "renders the show template" do
      get appointment_feedback_response_path(appointment_id: appointment.id, id: feedback_response.id)

      expect(response).to render_template(:show)
    end

    it "assigns the requested FeedbackResponse" do
      get appointment_feedback_response_path(appointment_id: appointment.id, id: feedback_response.id)

      expect(assigns(:feedback_response)).to eq(feedback_response)
    end
  end
end
