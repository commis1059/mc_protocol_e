# frozen_string_literal: true

require_relative '../../../lib/mc_protocol_e/frame_3e/batch_read_in_multiple'

include McProtocolE::Frame3e
describe BatchReadInMultiple do

  let(:object) {
    described_class.new(
      device_ranges: device_ranges
    )
  }
  let(:device_ranges) {
    [
      DeviceRange.data_register(device_num: 0, device_points: 4),
      DeviceRange.link_register(device_num: 100, device_points: 8),
      DeviceRange.internal_relay(device_num: 0, device_points: 2),
      DeviceRange.internal_relay(device_num: 128, device_points: 2),
      DeviceRange.link_relay(device_num: 100, device_points: 3),
    ]
  }

  describe "#parse" do
    subject { object.parse(res) }
    let(:res) {
      instance_double(
        "Response",
        code: 0,
        data: [
          "\x08\x00\x30\x20\x45\x15\x00\x28".b,
          "\x70\x09\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x31\x01",
          "\x30\x20\x49\x48",
          "\xDE\xC3\x00\x28",
          "\x70\x09\xAF\xB9\xAF\xB9",
        ].join,
        succeed?: succeed
      )
    }

    context "when res failed" do
      let(:data) { "\x00\xFF\xFF\x03\x00".b }
      let(:succeed) { false }
      it { expect { subject }.to raise_error CommandError }
    end

    context "when res succeed" do
      let(:succeed) { true }
      it { expect(subject.size).to eq 19 }
      it { expect(subject[0]).to eq "\x08\x00" }
      it { expect(subject[-1]).to eq "\xAF\xB9" }
    end
  end

  describe "#to_b" do
    subject { object.to_b }
    it { is_expected.to eq "\x06\x04\x00\x00".b + "\x02\x03".b + "\x00\x00\x00\xA8\x04\x00".b + "\x64\x00\x00\xB4\x08\x00".b + "\x00\x00\x00\x90\x02\x00".b + "\x80\x00\x00\x90\x02\x00".b + "\x64\x00\x00\xA0\x03\x00".b }
  end

end
