# frozen_string_literal: true

module McProtocolE
  module Frame3e
    # This class shows a access route.
    class AccessRoute

      OWN_NETWORK_NUM = 0
      OWN_PC_NUM = 255
      NORMAL_UNIT_IO_NUM = 1023
      NORMAL_UNIT_STATION_NUM = 0

      attr_reader :network_num, :pc_num, :unit_io_num, :unit_station_num

      # Constructor.
      # @param [Integer] network_num network number
      # @param [Integer] pc_num PC number
      # @param [Integer] unit_io_num unit io number
      # @param [Integer] unit_station_num unit station number
      def initialize(network_num:, pc_num:, unit_io_num:, unit_station_num:)
        @network_num = network_num
        @pc_num = pc_num
        @unit_io_num = unit_io_num
        @unit_station_num = unit_station_num
      end

      # Returns instance from binary string.
      # @param [String] raw binary string showing a access route
      # @return [AccessRoute] a access route
      def self.from_raw(raw)
        raise ArgumentError, "raw string is not access route" unless raw && raw.size >= 5

        new(
          network_num: raw[0].unpack1("C"),
          pc_num: raw[1].unpack1("C"),
          unit_io_num: raw[2..3].unpack1("v"),
          unit_station_num: raw[4].unpack1("C"),
        )
      end

      # Returns instance of own station.
      # @return [AccessRoute] a access route to own station
      def self.own_station
        new(network_num: OWN_NETWORK_NUM, pc_num: OWN_PC_NUM, unit_io_num: NORMAL_UNIT_IO_NUM, unit_station_num: NORMAL_UNIT_STATION_NUM)
      end

      # Returns binary string.
      # @return [String] binary string
      def to_b
        [
          [network_num].pack("v")[0],
          [pc_num].pack("v")[0],
          [unit_io_num].pack("v"),
          [unit_station_num].pack("v")[0],
        ].join
      end

      # Returns string.
      # @return [String] string
      def to_s
        "network num: #{network_num} pc num: #{pc_num} unit io num: #{unit_io_num} unit station num: #{unit_station_num}"
      end

    end
  end
end
