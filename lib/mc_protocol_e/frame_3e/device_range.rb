# frozen_string_literal: true

require 'forwardable'
require_relative 'device'

module McProtocolE
  module Frame3e
    # This class shows a device range.
    class DeviceRange
      extend Forwardable

      def_delegators :@device, :bit?, :word?

      # Constructor.
      # @param [Device] device device
      # @param [Integer] device_num first device number in range
      # @param [Integer] device_points number in range
      def initialize(device:, device_num:, device_points:)
        @device = device
        @device_num = device_num
        @device_points = device_points
      end

      # Returns device range of internal relay.
      # @param [Integer] device_num first device number in range
      # @param [Integer] device_points number in range
      def self.internal_relay(device_num:, device_points:)
        new(device: Device.internal_relay, device_num: device_num, device_points: device_points)
      end

      # Returns device range of link relay.
      # @param [Integer] device_num first device number in range
      # @param [Integer] device_points number in range
      def self.link_relay(device_num:, device_points:)
        new(device: Device.link_relay, device_num: device_num, device_points: device_points)
      end

      # Returns device range of data register.
      # @param [Integer] device_num first device number in range
      # @param [Integer] device_points number in range
      def self.data_register(device_num:, device_points:)
        new(device: Device.data_register, device_num: device_num, device_points: device_points)
      end

      # Returns device range of link register.
      # @param [Integer] device_num first device number in range
      # @param [Integer] device_points number in range
      def self.link_register(device_num:, device_points:)
        new(device: Device.link_register, device_num: device_num, device_points: device_points)
      end

      # Returns range size.
      # @return [Integer] range size
      def size
        device_points
      end

      # Returns binary string.
      # @return [String] binary string
      def to_b
        [[device_num].pack("V")[0..2], device.code, [device_points].pack("v")].join
      end

      private

      attr_reader :device, :device_num, :device_points

    end
  end
end
