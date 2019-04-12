# frozen_string_literal: true

require 'timeout'

module McProtocolE
  module Frame1e
    # This class shows a responce of MC protocol.
    class Response

      class TimeoutError < Timeout::Error; end

      DEFAULT_READ_TIMEOUT = 3
      MAX_RECV_LEN = 1024 * 1024
      SUCCEED_CODE = 0

      attr_reader :data

      # Constructor.
      # @param [String] raw_res binary string of response
      def initialize(raw_res)
        @sub_header = raw_res[0]
        @code = raw_res[1].unpack1("C")
        @data = raw_res[2..-1] || ""
      end

      # Receives responce and returns.
      # @param [IO] socket TCP socket
      # @param [Integer] read_timeout read timeout second
      # @return [Responce] received a response
      def self.recv(socket, read_timeout = DEFAULT_READ_TIMEOUT)
        selected = IO.select([socket], nil, nil, read_timeout)
        raise TimeoutError unless selected

        raw_res = socket.recv(MAX_RECV_LEN)
        new(raw_res)
      end

      # Returns true if a command succeed.
      def succeed?
        code == SUCCEED_CODE
      end

      # Returns true if a command failed.
      def failed?
        !succeed?
      end

      private

      attr_reader :code

    end
  end
end
