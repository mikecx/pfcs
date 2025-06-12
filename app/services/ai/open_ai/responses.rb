# frozen_string_literal: true

module Ai
  module OpenAi
    class Responses
      include HTTParty

      method_object [ :input, model: "gpt-4.1" ]

      ENDPOINT = "https://api.openai.com/v1/responses"
      API_KEY = "REPLACE_ME"

      def call
        response = HTTParty.post(ENDPOINT, {
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer #{API_KEY}"
          },
          body: {
            model:,
            input:
          }.to_json
        })

        output = HashWithIndifferentAccess.new(response.parsed_response).dig(:output)

        if output.present?
          output.dig(0, :content, 0, :text)
        else
          "No response returned from OpenAI"
        end
      end
    end
  end
end
