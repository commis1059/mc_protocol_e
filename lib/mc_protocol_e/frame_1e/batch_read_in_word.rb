# frozen_string_literal: true

require 'forwardable'

module McProtocolE
  module Frame1e
    # This class shows a command to batch read in word.
    class BatchReadInWord
      extend Forwardable

      REQUEST_HEADER = "\x01".b
      RESPONSE_HEADER = "\x81".b

      attr_reader :request_header
      def_delegators :@device_range, :to_b

      # Constructor.
      # @param [DeviceRange] device_range device range
      def initialize(device_range:)
        @request_header = REQUEST_HEADER
        @device_range = device_range
      end

      # Returns array of word.
      # @param [Response] res response
      # @return[Array] array of word
      def parse(res)
        res.data&.each_char&.each_slice(2)&.map(&:join)
      end

      private

      attr_reader :device_range

    end
  end
end
