# frozen_string_literal: true

class PatientsController < ApplicationController
  def index
    @patients = Patient.all.order(name: :asc)
  end

  def show
    @patient = Patient.find(params[:id])
  end
end
