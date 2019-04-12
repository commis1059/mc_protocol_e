# frozen_string_literal: true

require_relative '../../../lib/mc_protocol_e/frame_3e/error_info'

include McProtocolE::Frame3e
describe ErrorInfo do

  let(:object) { described_class.new(code, data, command) }
  let(:code) { 0 }
  let(:data) { "\x00\xFF\xFF\x03\x00".b }
  let(:command) { instance_double("BaseCommand") }

  describe "#to_s" do
    subject { object.to_s }
    it { is_expected.to eq "code: 0 command: #{command.class.name} network num: 0 pc num: 255 unit io num: 1023 unit station num: 0" }
  end

end
