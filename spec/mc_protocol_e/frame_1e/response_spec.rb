# frozen_string_literal: true

require_relative '../../../lib/mc_protocol_e/frame_1e/response'
require_relative '../../../lib/mc_protocol_e/frame_1e/batch_read_in_word'
require_relative '../../../lib/mc_protocol_e/frame_1e/batch_write_in_word'

include McProtocolE::Frame1e
describe Response do

  let(:object) { described_class.new(raw_res) }

  describe "#recv" do
    subject { McProtocolE::Frame1e::Response.recv(socket) }
    let(:socket) {
      double("socket").tap {|socket|
        allow(socket).to receive(:recv).and_return(raw_res)
      }
    }
    let(:raw_res) { McProtocolE::Frame1e::BatchReadInWord::RESPONSE_HEADER + "\x00".b + "\x01\x02".b }

    before {
      allow(IO).to receive(:select).and_return([socket])
    }

    context "when IO.select returned sockets" do
      it { is_expected.to be_a McProtocolE::Frame1e::Response }
    end

    context "when IO.select returned nil" do
      before {
        allow(IO).to receive(:select).and_return(nil)
      }
      it { expect { subject }.to raise_error McProtocolE::Frame1e::Response::TimeoutError }
    end
  end

  describe "#data" do
    subject { object.data }

    context "when data exists" do
      let(:raw_res) { McProtocolE::Frame1e::BatchReadInWord::RESPONSE_HEADER + "\x00".b + "\x01\x02".b }
      it { is_expected.to eq "\x01\x02".b }
    end

    context "when data does not exist" do
      let(:raw_res) { McProtocolE::Frame1e::BatchWriteInWord::RESPONSE_HEADER + "\x00".b }
      it { is_expected.to be_empty }
    end
  end

  describe "#succeed?" do
    subject { object.succeed? }

    context "when succeed" do
      let(:raw_res) { McProtocolE::Frame1e::BatchReadInWord::RESPONSE_HEADER + "\x00".b + "\x01\x02".b }
      it { is_expected.to eq true }
    end

    context "when failed" do
      let(:raw_res) { McProtocolE::Frame1e::BatchReadInWord::RESPONSE_HEADER + "\x01".b + "\x01\x02".b }
      it { is_expected.to eq false }
    end
  end

  describe "#failed?" do
    subject { object.failed? }

    context "when succeed" do
      let(:raw_res) { McProtocolE::Frame1e::BatchReadInWord::RESPONSE_HEADER + "\x00".b + "\x01\x02".b }
      it { is_expected.to eq false }
    end

    context "when failed" do
      let(:raw_res) { McProtocolE::Frame1e::BatchReadInWord::RESPONSE_HEADER + "\x01".b + "\x01\x02".b }
      it { is_expected.to eq true }
    end
  end

end
