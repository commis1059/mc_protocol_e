# frozen_string_literal: true

require_relative 'base_command'

module McProtocolE
  module Frame3e
    # This class shows a command to batch write in word.
    class BatchWriteInWord < BaseCommand

      COMMAND = "\x01\x14\x00\x00".b

      # Constructor.
      # @param [DeviceRange] device_range device range
      # @param [Array<Integer>] values values to write
      # @raise [ArgumentError] when arguments is invalid
      def initialize(device_range:, values:)
        super(COMMAND)
        @device_range = device_range
        @values = values

        validate
      end

      # Returns array of word.
      # @param [Response] res response
      # @return[Array] array of word
      def parse(res)
        super(res)

        res.data&.each_char&.each_slice(2)&.map(&:join)
      end

      # Returns binary string.
      # @return [String] binary string
      def to_b
        @to_b ||= command + device_range.to_b + values.pack("v*")
      end

      private

      attr_reader :device_range, :values

      def validate
        raise ArgumentError, "device points have to equal values size" unless device_range.size == values.size
        raise ArgumentError, "all value have to be an integer" unless values.all? {|value| value.is_a?(Integer) }

        true
      end

    end
  end
end
