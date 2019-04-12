# frozen_string_literal: true

require_relative '../../../lib/mc_protocol_e/frame_3e/response'

include McProtocolE::Frame3e
describe Response do

  let(:object) { described_class.new(raw_res) }

  describe "#recv" do
    subject { Response.recv(socket) }
    let(:socket) {
      double("socket").tap {|socket|
        allow(socket).to receive(:recv).and_return(raw_res)
      }
    }
    let(:raw_res) { Response::SUB_HEADER + "\x00\xFF\xFF\x03\x00".b + "\x02\x00".b + "\x00\x00".b }

    context "when IO.select returned sockets" do
      before {
        allow(IO).to receive(:select).and_return([socket])
      }
      it { is_expected.to be_a Response }
    end

    context "when IO.select returned nil" do
      before {
        allow(IO).to receive(:select).and_return(nil)
      }
      it { expect { subject }.to raise_error Response::TimeoutError }
    end
  end

  describe "#data" do
    subject { object.data }

    context "when data exists" do
      let(:raw_res) { Response::SUB_HEADER + "\x00\xFF\xFF\x03\x00".b + "\x02\x00".b + "\x00\x00".b + "\xFF\xFF".b }
      it { is_expected.to eq "\xFF\xFF".b }
    end

    context "when data does not exist" do
      let(:raw_res) { Response::SUB_HEADER + "\x00\xFF\xFF\x03\x00".b + "\x02\x00".b + "\x01\x00".b }
      it { is_expected.to be_empty }
    end
  end

  describe "#succeed?" do
    subject { object.succeed? }

    context "when succeed" do
      let(:raw_res) { Response::SUB_HEADER + "\x00\xFF\xFF\x03\x00".b + "\x02\x00".b + "\x00\x00".b }
      it { is_expected.to eq true }
    end

    context "when failed" do
      let(:raw_res) { Response::SUB_HEADER + "\x00\xFF\xFF\x03\x00".b + "\x02\x00".b + "\x01\x00".b }
      it { is_expected.to eq false }
    end
  end

  describe "#failed?" do
    subject { object.failed? }

    context "when succeed" do
      let(:raw_res) { Response::SUB_HEADER + "\x00\xFF\xFF\x03\x00".b + "\x02\x00".b + "\x00\x00".b }
      it { is_expected.to eq false }
    end

    context "when failed" do
      let(:raw_res) { Response::SUB_HEADER + "\x00\xFF\xFF\x03\x00".b + "\x02\x00".b + "\x01\x00".b }
      it { is_expected.to eq true }
    end
  end

end
