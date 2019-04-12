# frozen_string_literal: true

require 'socket'

module McProtocolE
  # This client shows a MC protocol client.
  class Client

    class NotStartedError < StandardError; end

    DEFAULT_OPEN_TIMEOUT = 3
    DEFAULT_READ_TIMEOUT = 3

    # Constructor.
    # @param [String] address server IP address
    # @param [Integer] port server port number
    # @param [Numeric] open_timeout second of open timeout
    # @param [Numeric] read_timeout second of read timeout
    def initialize(address:, port:, open_timeout: DEFAULT_OPEN_TIMEOUT, read_timeout: DEFAULT_READ_TIMEOUT)
      @address = address
      @port = port
      @open_timeout = open_timeout
      @read_timeout = read_timeout
      @socket = nil
    end

    # Starts MC protocol communication.
    # @param [String] address IP address
    # @param [Integer] port port number
    # @param [Numeric] open_timeout second of open timeout
    # @param [Numeric] read_timeout second of read timeout
    # @yield [client] MC protocol client
    def self.start(address:, port:, open_timeout: DEFAULT_OPEN_TIMEOUT, read_timeout: DEFAULT_READ_TIMEOUT, &block)
      client = new(address: address, port: port, open_timeout: open_timeout, read_timeout: read_timeout)

      if block_given?
        client.start(&block)
      else
        client
      end
    end

    # Closes MC protocol communication.
    def close
      socket.close if started?
    end

    # Sends request.
    # @param [Request] req request
    # @return [Object] response
    # @raise [NotStartedError] when not started
    def request(req)
      raise NotStartedError, "not started" unless started?

      req.exec(socket, read_timeout)
    end

    # Starts MC protocol communication.
    def start
      @socket = Socket.tcp(address, port, connect_timeout: open_timeout) unless started?

      if block_given?
        begin
          yield self
        ensure
          close
        end
      else
        self
      end
    end

    # Returns true if communication has started.
    def started?
      socket && !socket.closed?
    end

    private

    attr_reader :address, :port, :open_timeout, :read_timeout, :socket

  end
end
