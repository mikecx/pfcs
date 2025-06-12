# frozen_string_literal: true

require "rails_helper"

describe Ai::OpenAi::Responses, type: :service do
  describe "#call" do
    let(:model) { "gpt-4.1" }
    let(:input) { "Hello World!" }

    it "calls the OpenAI API with the correct prompt using HTTParty" do
      allow(HTTParty).to receive(:post).and_return(
        double(
          parsed_response: {
            "output": [
              "content": [
                {
                  "text": "Thank you for your feedback!"
                }
              ]
            ]
          }
        )
      )

      response = described_class.call(input:, model:)

      expect(response).to eq("Thank you for your feedback!")
    end

    it "raises an error if the OpenAI API call fails" do
      allow(HTTParty).to receive(:post).and_raise(HTTParty::Error.new("API error"))

      expect { described_class.call(input:, model:) }.to raise_error(HTTParty::Error, "API error")
    end
  end
end
