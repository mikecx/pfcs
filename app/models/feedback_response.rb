# frozen_string_literal: true

class FeedbackResponse < ApplicationRecord
  validates :nps_score, presence: true, inclusion: { in: 1..10 }

  belongs_to :appointment

  has_one :doctor, through: :appointment
  has_one :patient, through: :appointment
  has_one :diagnosis, through: :appointment

  after_commit :process_feedback, on: :create

  def feedback_document
    <<~FEEDBACK
      Overall doctor rating where 1 is bad and 10 is amazing: #{nps_score}

      Was the diagnosis management plan understood: #{management_understood}

      Feedback on the doctor's communication around the diagnosis management: #{management_feedback}

      Feedback on how the patient feels about the diagnosis: #{diagnosis_feedback}
    FEEDBACK
  end

  def ai_sentiment
    question = <<~QUESTION
      Use the feedback document to determine the sentiment of the patient's feedback. If the feedback is positive,
      return a thank you message. If the feedback is negative, return an apology and a promise to improve. If the feedback
      is neutral, simply acknowledge the feedback.

      Here is the feedback document: #{feedback_document}
    QUESTION

    ::Ai::OpenAi::Responses.call(
      input: prompt_with_persona(question:)
    )
  end

  def ai_more_information
    question = <<~QUESTION
      Based on the diagnosis #{diagnosis.human_readable}, provide any additional information that might be relevant to the patient.
      This could include treatment options, lifestyle changes, or any other relevant information.
    QUESTION

    ::Ai::OpenAi::Responses.call(
      input: prompt_with_persona(question:)
    )
  end

  def ai_organizations_and_groups
    question = <<~QUESTION
      Based on the diagnosis #{diagnosis.human_readable}, identify any organizations or groups that might be relevant to
      helping the support the patient in dealing with their diagnosis. Provide a list of these organizations or groups or
       if they don't exist, return a message about how speaking with a therapist might help.'
    QUESTION

    ::Ai::OpenAi::Responses.call(
      input: prompt_with_persona(question:)
    )
  end

  def process_feedback
    PatientsMailer.feedback_followup(feedback_response: self).deliver_later
  end

  private

  def prompt_with_persona(question:)
    <<~PROMPT
      You are a medical assistant who is responsible for providing after-care information to patients after their doctor
      appointments. You should be empathic and understanding, while also being professional and concise. Do not include#{' '}
      a thank you or apology unless the patient has provided feedback that warrants it.

      #{question}
    PROMPT
  end
end
