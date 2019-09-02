# frozen_string_literal: true

require_relative '../../../lib/mc_protocol_e/frame_3e/device'

include McProtocolE::Frame3e
describe Device do

  describe "#data_register" do
    subject { described_class.data_register }
    it { expect(subject.code).to eq described_class::Code::DATA_REGISTER }
  end

  describe "#bit?" do
    subject { object.bit? }

    context "when device is bit" do
      let(:object) { described_class.link_relay }
      it { is_expected.to be_truthy }
    end

    context "when device is not bit" do
      let(:object) { described_class.data_register }
      it { is_expected.to be_falsey }
    end
  end

  describe "#word?" do
    subject { object.word? }

    context "when device is word" do
      let(:object) { described_class.data_register }
      it { is_expected.to be_truthy }
    end

    context "when device is not word" do
      let(:object) { described_class.link_relay }
      it { is_expected.to be_falsey }
    end
  end

end
