# frozen_string_literal: true

require 'rails_helper'

describe "Patients", type: :request do
  describe "GET /index" do
    let!(:bob) { create(:patient, name: "Bob") }
    let!(:shawn) { create(:patient, name: "Shawn") }

    it "returns http success" do
      get patient_index_path

      expect(response).to have_http_status(:success)
    end

    it "renders the index template" do
      get patient_index_path

      expect(response).to render_template(:index)
    end

    it 'assigns @patients' do
      get patient_index_path

      expect(assigns(:patients)).to include(bob, shawn)
    end
  end

  describe "GET /show" do
    let!(:patient) { create(:patient) }

    it "returns http success" do
      get patient_path(id: patient.id)

      expect(response).to have_http_status(:success)
    end

    it "renders the show template" do
      get patient_path(id: patient.id)

      expect(response).to render_template(:show)
    end

    it "assigns @patient" do
      get patient_path(id: patient.id)

      expect(assigns(:patient)).to eq(patient)
    end
  end
end
