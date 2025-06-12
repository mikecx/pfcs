# frozen_string_literal: true

class PatientsMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.patients_mailer.after_care.subject
  #
  def feedback_followup(feedback_response:)
    email = feedback_response&.patient&.contacts&.where(system: :email)&.first&.value
    return if email.blank?

    @patient = feedback_response.patient
    @appointment = feedback_response.appointment

    @sentiment = feedback_response.ai_sentiment
    @more_information = feedback_response.ai_more_information
    @organizations_and_groups = feedback_response.ai_organizations_and_groups

    mail to: email, subject: "Appointment feedback follow-up"
  end
end
