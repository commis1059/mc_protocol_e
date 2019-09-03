# frozen_string_literal: true

require 'timeout'

module McProtocolE
  module Frame3e
    # This class shows a responce of MC protocol.
    class Response

      class ReadTimeoutError < Timeout::Error; end
      class InvalidResponseError < StandardError; end

      DEFAULT_READ_TIMEOUT = 3
      SUB_HEADER = "\xD0\x00".b
      MAX_RECV_LEN = 1024 * 1024
      SUCCEED_CODE = 0

      attr_reader :code, :data

      # Constructor.
      # @param [String] raw_res binary string of response
      def initialize(raw_res)
        @sub_header = raw_res[0..1]
        @access_route = raw_res[2..6]
        @response_len = raw_res[7..8]
        @code = raw_res[9..10]&.unpack1("v")
        @data = raw_res[11..-1] || ""
      end

      # Receives responce and returns.
      # @param [IO] socket TCP socket
      # @param [Integer] read_timeout read timeout second
      # @return [Responce] received a response
      # @raise [ReadTimeoutError] occurred timeout when response read
      # @raise [InvalidResponseError] when response is invalid mc protocol format
      def self.recv(socket, read_timeout = DEFAULT_READ_TIMEOUT)
        selected = IO.select([socket], nil, nil, read_timeout)
        raise ReadTimeoutError unless selected

        raw_res = socket.recv(MAX_RECV_LEN)
        res = new(raw_res)
        raise InvalidResponseError if res.code.nil?
        res
      end

      # Returns true if a command succeed.
      def succeed?
        code == SUCCEED_CODE
      end

      # Returns true if a command failed.
      def failed?
        !succeed?
      end

    end
  end
end
