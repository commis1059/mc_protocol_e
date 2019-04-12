# frozen_string_literal: true

require_relative 'access_route'

module McProtocolE
  module Frame3e
    # This class shows a error information.
    class ErrorInfo

      # Constructor.
      # @param [Integer] code MC protocol error code
      # @param [String] data response
      # @param [Object] command command
      def initialize(code, data, command)
        @code = code
        @access_route = AccessRoute.from_raw(data[0..4])
        @command = command
      end

      # Returns binary string.
      # @return [String] binary string
      def to_s
        "code: #{code} command: #{command.class.name} #{access_route}"
      end

      private

      attr_reader :code, :access_route, :command

    end
  end
end
