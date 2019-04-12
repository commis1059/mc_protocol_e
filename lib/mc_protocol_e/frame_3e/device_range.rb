# frozen_string_literal: true

module McProtocolE
  module Frame3e
    # This class shows a device range.
    class DeviceRange

      module DeviceCode
        DATA_REGISTER = "\xA8".b
      end

      # Constructor.
      # @param [String] device_code device code
      # @param [Integer] device_num first device number in range
      # @param [Integer] device_points number in range
      def initialize(device_code:, device_num:, device_points:)
        @device_code = device_code
        @device_num = device_num
        @device_points = device_points
      end

      # Returns device range of data register.
      # @param [Integer] device_num first device number in range
      # @param [Integer] device_points number in range
      def self.data_register(device_num:, device_points:)
        new(device_code: DeviceCode::DATA_REGISTER, device_num: device_num, device_points: device_points)
      end

      # Returns range size.
      # @return [Integer] range size
      def size
        device_points
      end

      # Returns binary string.
      # @return [String] binary string
      def to_b
        [[device_num].pack("V")[0..2], device_code, [device_points].pack("v")].join
      end

      private

      attr_reader :device_code, :device_num, :device_points

    end
  end
end
