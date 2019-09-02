# frozen_string_literal: true

require_relative 'base_command'

module McProtocolE
  module Frame3e
    # This class shows a command to batch read in word.
    class BatchReadInMultiple < BaseCommand

      COMMAND = "\x06\x04\x00\x00".b

      # Constructor.
      # @param [DeviceRange] device_range device range
      def initialize(device_ranges:)
        super(COMMAND)
        @device_ranges = device_ranges
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
        @to_b ||=
          command +
          [word_block_num].pack("v")[0] +
          [bit_block_num].pack("v")[0] +
          device_ranges.map(&:to_b).join
      end

      private

      attr_reader :device_ranges

      def word_block_num
        device_ranges.select(&:word?).size
      end

      def bit_block_num
        device_ranges.select(&:bit?).size
      end

    end
  end
end
