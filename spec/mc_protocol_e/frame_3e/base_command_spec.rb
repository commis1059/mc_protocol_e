# frozen_string_literal: true

require_relative '../../../lib/mc_protocol_e/frame_3e/base_command'

include McProtocolE::Frame3e
describe BaseCommand do

  let(:object) {
    described_class.new(command)
  }
  let(:command) { instance_double("BaseCommand") }

  describe "#parse" do
    subject { object.parse(res) }
    let(:res) { instance_double("Response", code: 0, data: "12345", succeed?: succeed) }

    context "when res succeed" do
      let(:succeed) { true }
      it { expect { subject }.not_to raise_error }
    end

    context "when res failed" do
      let(:succeed) { false }
      it { expect { subject }.to raise_error CommandError }
    end
  end
end
