# frozen_string_literal: true

require 'rails_helper'

describe "Doctors", type: :request do
  describe "GET /index" do
    let!(:doctor_smith) { create(:doctor, name: "Dr. Smith") }
    let!(:doctor_phil) { create(:doctor, name: "Dr. Phil") }

    it "returns http success" do
      get doctor_index_path

      expect(response).to have_http_status(:success)
    end

    it "renders the index template" do
      get doctor_index_path

      expect(response).to render_template(:index)
    end

    it 'assigns @doctors' do
      get doctor_index_path

      expect(assigns(:doctors)).to include(doctor_phil, doctor_smith)
    end
  end

  describe "GET /show" do
    let!(:doctor) { create(:doctor) }

    it "returns http success" do
      get doctor_path(id: doctor.id)

      expect(response).to have_http_status(:success)
    end

    it "renders the show template" do
      get doctor_path(id: doctor.id)

      expect(response).to render_template(:show)
    end

    it "assigns @doctor" do
      get doctor_path(id: doctor.id)

      expect(assigns(:doctor)).to eq(doctor)
    end
  end
end
