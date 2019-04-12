# frozen_string_literal: true

require_relative '../../../lib/mc_protocol_e/frame_3e/access_route'

include McProtocolE::Frame3e
describe AccessRoute do

  let(:object) {
    described_class.new(
      network_num: network_num,
      pc_num: pc_num,
      unit_io_num: unit_io_num,
      unit_station_num: unit_station_num,
    )
  }

  describe "#from_raw" do
    subject { AccessRoute.from_raw(raw) }

    context "when raw is nil" do
      let(:raw) { nil }
      it { expect { subject }.to raise_error ArgumentError }
    end

    context "when raw is less than 5 character" do
      let(:raw) { "" }
      it { expect { subject }.to raise_error ArgumentError }
    end

    context "when raw is more than 5 character" do
      let(:raw) { "\x00\xFF\xFF\x03\x00".b }
      it { expect(subject.network_num).to eq AccessRoute::OWN_NETWORK_NUM }
      it { expect(subject.pc_num).to eq AccessRoute::OWN_PC_NUM }
      it { expect(subject.unit_io_num).to eq AccessRoute::NORMAL_UNIT_IO_NUM }
      it { expect(subject.unit_station_num).to eq AccessRoute::NORMAL_UNIT_STATION_NUM }
    end
  end

  describe "#own_station" do
    subject { AccessRoute.own_station }

    it { expect(subject.network_num).to eq AccessRoute::OWN_NETWORK_NUM }
    it { expect(subject.pc_num).to eq AccessRoute::OWN_PC_NUM }
    it { expect(subject.unit_io_num).to eq AccessRoute::NORMAL_UNIT_IO_NUM }
    it { expect(subject.unit_station_num).to eq AccessRoute::NORMAL_UNIT_STATION_NUM }
  end

  describe "#to_b" do
    context "when access route is own station" do
      subject { AccessRoute.own_station.to_b }
      it { is_expected.to eq "\x00\xFF\xFF\x03\x00".b }
    end
  end

  describe "#to_s" do
    context "when access route is own station" do
      subject { AccessRoute.own_station.to_s }
      it { is_expected.to eq "network num: 0 pc num: 255 unit io num: 1023 unit station num: 0" }
    end
  end

end
