require 'spec_helper'

RSpec.describe Esplanade::Request::Validation do
  subject { described_class.new(raw, doc) }

  let(:raw) { double }
  let(:doc) { double }

  describe '#error' do
    let(:error) { double }
    let(:raw) { double(body: double(to_h: double)) }
    let(:doc) { double(json_schema: double) }
    before { allow(JSON::Validator).to receive(:fully_validate).and_return(error) }
    it { expect(subject.error).to eq(error) }

    context 'does not have json-schema' do
      let(:doc) { double(json_schema: nil) }
      it { expect(subject.error).to be_nil }
    end
  end

  describe '#valid?' do
    before { allow(subject).to receive(:error).and_return([]) }
    it { expect(subject.valid?).to be_truthy }

    context 'invalid' do
      before { allow(subject).to receive(:error).and_return(double) }
      it { expect(subject.valid?).to be_falsey }
    end
  end
end
