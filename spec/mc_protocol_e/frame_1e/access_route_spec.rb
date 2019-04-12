# frozen_string_literal: true

require_relative '../../../lib/mc_protocol_e/frame_1e/access_route'

include McProtocolE::Frame1e
describe AccessRoute do

  let(:object) {
    described_class.new(pc_num: pc_num)
  }

  describe "#own_station" do
    subject { McProtocolE::Frame1e::AccessRoute.own_station }

    it { expect(subject.pc_num).to eq McProtocolE::Frame1e::AccessRoute::OWN_PC_NUM }
  end

  describe "#to_b" do
    context "when access route is own station" do
      subject { McProtocolE::Frame1e::AccessRoute.own_station.to_b }
      it { is_expected.to eq "\xFF".b }
    end
  end

end
