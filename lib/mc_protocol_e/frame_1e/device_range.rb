# frozen_string_literal: true

require_relative 'device'

module McProtocolE
  module Frame1e
    # This class shows a device range.
    class DeviceRange

      FIXED_VALUE = "\x00".b

      # Constructor.
      # @param [String] device device
      # @param [Integer] device_num first device number in range
      # @param [Integer] device_points number in range
      def initialize(device:, device_num:, device_points:)
        @device = device
        @device_num = device_num
        @device_points = device_points
      end

      # Returns device range of data register.
      # @param [Integer] device_num first device number in range
      # @param [Integer] device_points number in range
      def self.data_register(device_num:, device_points:)
        new(device: Device.data_register, device_num: device_num, device_points: device_points)
      end

      # Returns range size.
      # @return [Integer] range size
      def size
        device_points
      end

      # Returns binary string.
      # @return [String] binary string
      def to_b
        [[device_num].pack("V"), device.code, [device_points].pack("v")[0], FIXED_VALUE].join
      end

      private

      attr_reader :device, :device_num, :device_points

    end
  end
end
