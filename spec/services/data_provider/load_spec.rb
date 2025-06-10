# frozen_string_literal: true

require 'rails_helper'

describe DataProvider::Load do
  subject(:call) { described_class.call(file_path:) }

  let(:file_path) { "data/patient_feedback_raw_data.json" }

  describe '#call' do
    context 'when the file exists' do
      before do
        allow(ParseRecordsJob).to receive(:perform_later)
      end

      it 'calls ParseRecordsJob with the correct file path' do
        call

        expect(ParseRecordsJob).to have_received(:perform_later).with(file_path:)
      end
    end

    context 'when the file does not exist' do
      let(:file_path) { 'non_existent_file.json' }

      before do
        allow(ParseRecordsJob).to receive(:perform_later)
      end

      it 'raises an Errno::ENOENT error' do
        expect { call }.to raise_error(Errno::ENOENT, "No such file or directory - Data not found")
      end

      it 'does not call ParseRecordsJob' do
        expect(ParseRecordsJob).not_to have_received(:perform_later)
      end
    end
  end
end
