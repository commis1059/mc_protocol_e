# frozen_string_literal: true

require_relative '../../../lib/mc_protocol_e/frame_3e/batch_write_in_word'

include McProtocolE::Frame3e
describe BatchWriteInWord do

  let(:object) { described_class.new(device_range: device_range, values: values) }
  let(:device_range) { instance_double("DeviceRange", size: 3, to_b: "\x64\x00\x00\xC2\x03\x00".b) }
  let(:values) { [4660, 2, 7663] }

  describe "#initialize" do
    subject { object }

    context "when values size is not equal range size" do
      let(:values) { [] }
      it { expect { subject }.to raise_error ArgumentError }
    end

    context "when values include charcter value" do
      let(:values) { [4660, 2, "7663"] }
      it { expect { subject }.to raise_error ArgumentError }
    end
  end

  describe "#parse" do
    subject { object.parse(res) }
    let(:res) { instance_double("Response", code: 0, data: data, succeed?: succeed) }

    context "when res failed" do
      let(:data) { "\x64\x00\x00\xC2\x03\x00".b + described_class::COMMAND }
      let(:succeed) { false }
      it { expect { subject }.to raise_error CommandError }
    end

    context "when res succeed" do
      let(:data) { "".b }
      let(:succeed) { true }
      it { is_expected.to be_empty }
    end
  end

  describe "#to_b" do
    subject { object.to_b }
    it { is_expected.to eq BatchWriteInWord::COMMAND + device_range.to_b + "\x34\x12\x02\x00\xEF\x1D".b }
  end

end
