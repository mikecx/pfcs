# frozen_string_literal: true

module Appointments
  class FeedbackResponsesController < ApplicationController
    def new
      @appointment = Appointment.find(params[:appointment_id])
      @feedback_response = FeedbackResponse.new(appointment: @appointment)
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "Appointment not found."
      redirect_to root_path
    end

    def create
      @appointment = Appointment.find(params[:appointment_id])
      @feedback_response = FeedbackResponse.new(feedback_response_params)
      @feedback_response.appointment = @appointment

      if @feedback_response.save
        flash[:notice] = "Feedback submitted successfully."
        redirect_to appointment_feedback_response_path(@appointment, @feedback_response)
      else
        flash.now[:alert] = "Error submitting feedback."
        render :new
      end
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "Appointment not found."
      redirect_to root_path
    end

    def show
      @feedback_response = FeedbackResponse.find(params[:id])
    end

    private

    def feedback_response_params
      params.require(:feedback_response).permit(:nps_score, :management_understood, :management_feedback, :diagnosis_feedback)
    rescue ActionController::ParameterMissing
      flash.now[:alert] = "Required parameters are missing."
      render :new
    end
  end
end
