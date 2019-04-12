# frozen_string_literal: true

require 'forwardable'

module McProtocolE
  module Frame1e
    # This class shows a command to batch read in word.
    class BatchWriteInWord
      extend Forwardable

      REQUEST_HEADER = "\x03".b
      RESPONSE_HEADER = "\x83".b

      attr_reader :request_header

      # Constructor.
      # @param [DeviceRange] device_range device range
      # @param [Array<Integer>] values values to write
      # @raise [ArgumentError] when arguments is invalid
      def initialize(device_range:, values:)
        @request_header = REQUEST_HEADER
        @device_range = device_range
        @values = values

        validate
      end

      # Returns array of word.
      # @param [Response] res response
      # @return[Array] array of word
      def parse(res)
        res.data&.each_char&.each_slice(2)&.map(&:join)
      end

      # Returns binary string.
      # @return [String] binary string
      def to_b
        @to_b ||= device_range.to_b + values.pack("v*")
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
