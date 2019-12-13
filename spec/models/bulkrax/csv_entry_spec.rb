# frozen_string_literal: true

require 'rails_helper'

module Bulkrax
  RSpec.describe CsvEntry, type: :model do
    describe 'builds entry' do
      let(:importer) { FactoryBot.build(:bulkrax_importer_csv) }
      subject { described_class.new(importerexporter: importer) }

      before do
        Bulkrax.default_work_type = 'Work'
      end

      context 'without required metadata' do
        before(:each) do
          allow(subject).to receive(:record).and_return(source_identifier: '1', some_field: 'some data')
        end

        it 'fails and stores an error' do
          subject.identifier = 1
          expect { subject.build_metadata }.to raise_error(StandardError)
        end
      end

      context 'with required metadata' do
        before(:each) do
          allow_any_instance_of(ObjectFactory).to receive(:run)
          allow_any_instance_of(User).to receive(:batch_user)
          allow(subject).to receive(:record).and_return('source_identifier' => '2', 'title' => 'some title')
        end

        it 'succeeds' do
          subject.identifier = 2
          subject.build
          expect(subject.status).to eq('succeeded')
        end
      end
    end
  end
end
