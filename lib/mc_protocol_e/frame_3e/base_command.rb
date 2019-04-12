# frozen_string_literal: true

require_relative 'error_info'

module McProtocolE
  module Frame3e

    class CommandError < StandardError; end

    class BaseCommand

      def initialize(command)
        @command = command
      end

      def parse(res)
        raise CommandError, ErrorInfo.new(res.code, res.data, self).to_s unless res.succeed?
      end

      private

      attr_reader :command

    end

  end
end
