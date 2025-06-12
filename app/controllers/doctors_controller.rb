# frozen_string_literal: true

class DoctorsController < ApplicationController
  def index
    @doctors = Doctor.all.order(name: :asc)
  end

  def show
    @doctor = Doctor.includes(:feedback_responses).find(params[:id])
    scores = @doctor.feedback_responses.pluck(:nps_score).compact
    @mean_nps = scores.any? ? scores.sum.to_f / scores.size : 0
  end
end
