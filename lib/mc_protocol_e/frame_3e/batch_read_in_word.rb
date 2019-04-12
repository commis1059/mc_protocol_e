# frozen_string_literal: true

require_relative 'base_command'

module McProtocolE
  module Frame3e
    # This class shows a command to batch read in word.
    class BatchReadInWord < BaseCommand

      COMMAND = "\x01\x04\x00\x00".b

      # Constructor.
      # @param [DeviceRange] device_range device range
      def initialize(device_range:)
        super(COMMAND)
        @device_range = device_range
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
        @to_b ||= command + device_range.to_b
      end

      private

      attr_reader :device_range

    end
  end
end
