# frozen_string_literal: true

require_relative '../../../lib/mc_protocol_e/frame_1e/device_range'

include McProtocolE::Frame1e
describe DeviceRange do

  let(:object) { described_class.data_register(device_num: device_num, device_points: device_points) }
  let(:device_num) { 3002 }
  let(:device_points) { 18 }

  describe "#size" do
    subject { object.size }
    it { is_expected.to eq device_points }
  end

  describe "#to_b" do
    context "when device code is data register" do
      subject { object.to_b }

      it { is_expected.to eq "\xBA\x0B\x00\x00\x20\x44\x12\x00".b }
    end
  end

end
