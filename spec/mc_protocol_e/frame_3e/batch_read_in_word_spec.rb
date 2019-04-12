# frozen_string_literal: true

require_relative '../../../lib/mc_protocol_e/frame_3e/batch_read_in_word'

include McProtocolE::Frame3e
describe BatchReadInWord do

  let(:object) { described_class.new(device_range: device_range) }
  let(:device_range) { instance_double("DeviceRange", to_b: "\x64\x00\x00\xC2\x03\x00".b) }

  describe "#parse" do
    subject { object.parse(res) }
    let(:res) { instance_double("Response", code: 0, data: "\x34\x12\x02\x00\xEF\x1D".b, succeed?: succeed) }

    context "when res failed" do
      let(:succeed) { false }
      it { expect { subject }.to raise_error CommandError }
    end

    context "when res succeed" do
      let(:succeed) { true }
      it { is_expected.to eq ["\x34\x12".b, "\x02\x00".b, "\xEF\x1D".b] }
    end
  end

  describe "#to_b" do
    subject { object.to_b }
    it { is_expected.to eq BatchReadInWord::COMMAND + device_range.to_b }
  end

end
