# frozen_string_literal: true

require 'rails_helper'

describe ParseRecordsJob, type: :job do
  describe 'perform' do
    subject(:call) { ParseRecordsJob.perform_now(file_path:) }
    let(:file_path) { Rails.root.join('data', 'patient_feedback_raw_data.json') }

    describe 'file loading' do
      context 'when the file is not found' do
        let(:file_path) { 'non_existent_file.json' }

        it 'raises an error' do
          expect { call }.to raise_error(Errno::ENOENT, /No such file or directory/)
        end
      end

      context 'when the file is found' do
        it 'loads the file successfully' do
          expect { call }.not_to raise_error
        end
      end
    end

    describe 'entry parsing' do
      before do
        allow(EntryParser::Patient).to receive(:call)
        allow(EntryParser::Doctor).to receive(:call)
        allow(EntryParser::Appointment).to receive(:call)
        allow(EntryParser::Diagnosis).to receive(:call)
      end

      it 'parses each entry in the file' do
        call

        expect(EntryParser::Patient).to have_received(:call).once
        expect(EntryParser::Doctor).to have_received(:call).once
        expect(EntryParser::Appointment).to have_received(:call).once
        expect(EntryParser::Diagnosis).to have_received(:call).once
      end

      it 'logs unsupported resource types' do
        allow(Rails.logger).to receive(:warn)

        unsupported_entry = {
          resource: {
            id: 'unsupported_id',
            resourceType: 'UnsupportedType'
          }
        }
        allow(JSON).to receive(:parse).and_return({ entry: [ unsupported_entry ] })

        call

        expect(Rails.logger).to have_received(:warn).with("Unsupported resource type: UnsupportedType for: unsupported_id")
      end
    end
  end
end
