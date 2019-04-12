# frozen_string_literal: true

require_relative '../../lib/mc_protocol_e/client'

include McProtocolE
describe Client do

  let(:object) {
    described_class.new(
      address: address,
      port: port
    )
  }
  let(:address) { "127.0.0.1" }
  let(:port) { 80 }

  describe "#close" do
    subject { object.close }

    context "when started" do
      let(:socket) { instance_double("Socket", closed?: closed) }
      let(:closed) { false }
      before {
        allow(Socket).to receive(:tcp).and_return(socket)
        expect(socket).to receive(:close)
        object.start
      }

      it { is_expected.to be_nil }
    end

    context "when not stared" do
      it { is_expected.to be_nil }
    end
  end

  describe "#request" do
    subject { object.request(req) }
    let(:req) { instance_double("McProtocolE::Frame3e::Request") }

    context "when started" do
      let(:socket) { instance_double("Socket", closed?: closed) }
      let(:closed) { false }
      before {
        allow(Socket).to receive(:tcp).and_return(socket)
        object.start
        expect(req).to receive(:exec).and_return("")
      }
      it { is_expected.to be_empty }
    end

    context "when not started" do
      it { expect { subject }.to raise_error Client::NotStartedError }
    end
  end

  describe "#start" do
    subject { object.start }
    let(:socket) { instance_double("Socket", closed?: closed) }
    let(:closed) { false }
    before {
      allow(Socket).to receive(:tcp).and_return(socket)
    }

    it { is_expected.to eq object }
  end

  describe "#started?" do
    subject { object.started? }

    context "when started" do
      let(:socket) { instance_double("Socket", closed?: closed) }
      let(:closed) { false }
      before {
        allow(Socket).to receive(:tcp).and_return(socket)
        object.start
      }
      it { is_expected.to be_truthy }
    end

    context "when not started" do
      it { is_expected.to be_falsey }
    end
  end

end
