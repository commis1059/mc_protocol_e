# frozen_string_literal: true

require_relative '../../../lib/mc_protocol_e/frame_3e/request'
require_relative '../../../lib/mc_protocol_e/frame_3e/device_range'

include McProtocolE::Frame3e
describe Request do

  let(:object) {
    Request.new(
      access_route: access_route,
      wait_sec: wait_sec,
      command: command,
    )
  }
  let(:wait_sec) { 5 }

  describe "#exec" do
    subject { object.exec(socket) }
    let(:access_route) { AccessRoute.own_station }
    let(:command) {
      double("command").tap {|command|
        allow(command).to receive(:to_b).and_return("\x01\x04\x00\x00\xBA\x0B\x00\xA8\x12\x00".b)
        allow(command).to receive(:parse).and_return(ret)
      }
    }
    let(:ret) { "" }
    let(:socket) {
      double("socket").tap {|socket|
        allow(socket).to receive(:write)
        allow(socket).to receive(:recv).and_return(raw_res)
      }
    }
    let(:raw_res) { Response::SUB_HEADER + "\x00\xFF\xFF\x03\x00".b + "\x02\x00".b + "\x00\x00".b }

    before {
      allow(IO).to receive(:select).and_return([socket])
    }

    it { is_expected.to eq ret }
  end

  describe "#to_b" do
    subject { object.to_b }

    context "when access route is own station" do
      let(:access_route) { AccessRoute.own_station }

      context "when command is batch read in ward" do
        let(:command) { BatchReadInWord.new(device_range: device_range) }

        context "when device code is data register" do
          let(:device_range) { DeviceRange.data_register(device_num: device_num, device_points: device_points) }
          let(:device_num) { 3002 }
          let(:device_points) { 18 }

          it { is_expected.to eq String.new("\x50\x00" + "\x00\xFF\xFF\x03\x00" + "\x0C\x00" + "\x14\x00" + "\x01\x04\x00\x00" + "\xBA\x0B\x00\xA8\x12\x00", encoding: "ASCII-8BIT") }
        end
      end

    end
  end

end
