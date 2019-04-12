# frozen_string_literal: true

require_relative 'batch_read_in_word'
require_relative 'batch_write_in_word'
require_relative 'response'

module McProtocolE
  module Frame3e
    # This class shows a request of MC protocol.
    class Request

      DEFAULT_READ_TIMEOUT = 3
      SUB_HEADER = "\x50\x00".b

      # Constructor.
      # @param [AccessRoute] access_route access route
      # @param [Numeric] wait_sec waiting second
      # @param [Object] command command of MC protocol
      def initialize(access_route:, wait_sec:, command:)
        @sub_header = SUB_HEADER
        @access_route = access_route
        @wait_sec = WaitSec.new(wait_sec)
        @command = command
      end

      # Returns a request to batch read.
      # @param [AccessRoute] access_route access route
      # @param [Numeric] wait_sec waiting second
      # @param [DeviceRange] device_range device_range
      def self.batch_read_in_word(access_route:, wait_sec:, device_range:)
        new(access_route: access_route, wait_sec: wait_sec, command: BatchReadInWord.new(device_range: device_range))
      end

      # Returns a request to batch write.
      # @param [AccessRoute] access_route access route
      # @param [Numeric] wait_sec waiting second
      # @param [DeviceRange] device_range device_range
      # @param [Array] values values to write
      def self.batch_write_in_word(access_route:, wait_sec:, device_range:, values:)
        new(access_route: access_route, wait_sec: wait_sec, command: BatchWriteInWord.new(device_range: device_range, values: values))
      end

      # Writes and returns a response.
      # @param [IO] socket TCP socket
      # @param [Integer] read_timeout read timeout second
      # @return [Object] responce
      def exec(socket, read_timeout = DEFAULT_READ_TIMEOUT)
        socket.write(to_b)
        res = Response.recv(socket, read_timeout)
        command.parse(res)
      end

      # Returns binary string.
      # @return [String] binary string
      def to_b
        sub_header + access_route.to_b + request_len_to_b + wait_sec.to_b + command.to_b
      end

      private

      attr_reader :sub_header, :access_route, :wait_sec, :command

      def request_len_to_b
        [wait_sec.to_b.size + command.to_b.size].pack("v")
      end

    end

    # This class shows waiting second for MC protocol.
    class WaitSec

      def initialize(sec)
        @sec = sec
      end

      def to_b
        return @binary if @binary

        quarter_sec = (sec * 4).to_i
        @binary = [quarter_sec].pack("v")
      end

      private

      attr_reader :sec

    end
  end
end
