# frozen_string_literal: true

require_relative '../../../lib/mc_protocol_e/frame_3e/request'

include McProtocolE::Frame3e
describe WaitSec do

  let(:object) {
    described_class.new(wait_sec)
  }

  describe "#to_b" do
    subject { object.to_b }

    context "when wait sec is 0" do
      let(:wait_sec) { 0 }
      it { is_expected.to eq "\x00\x00".b }
    end

    context "when wait sec is 5" do
      let(:wait_sec) { 5 }
      it { is_expected.to eq "\x14\x00".b }
    end
  end

end
