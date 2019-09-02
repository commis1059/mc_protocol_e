# frozen_string_literal: true

module McProtocolE
  module Frame1e
    # This class shows a device.
    class Device

      module Code
        INPUT = "\x20\x58".b
        OUTPUT = "\x20\x59".b
        INTERNAL_RELAY = "\x20\x4D".b
        ANNUNCIATOR = "\x20\x46".b
        LINK_RELAY = "\x20\x42".b
        TIMER_CURRENT_VALUE = "\x4E\x54".b
        TIMER_CONTACT = "\x53\x54".b
        TIMER_COIL = "\x43\x54".b
        COUNTER_CURRENT_VALUE = "\x4E\x43".b
        COUNTER_CONTACT = "\x53\x43".b
        COUNTER_COIL = "\x43\x43".b
        DATA_REGISTER = "\x20\x44".b
        LINK_REGISTER = "\x20\x57".b
        FILE_REGISTER = "\x20\x52".b
      end

      module Type
        WORD = :word
        BIT = :bit
      end

      attr_reader :code

      # Constructor.
      # @param [String] code device code
      # @param [Symbol] type device type
      def initialize(code:, type:)
        @code = code
        @type = type
      end

      def self.input
        new(code: Code::INPUT, type: Type::BIT)
      end

      def self.output
        new(code: Code::OUTPUT, type: Type::BIT)
      end

      def self.internal_relay
        new(code: Code::INTERNAL_RELAY, type: Type::BIT)
      end

      def self.annunciator
        new(code: Code::ANNUNCIATOR, type: Type::BIT)
      end

      def self.link_relay
        new(code: Code::LINK_RELAY, type: Type::BIT)
      end

      def self.timer_current_value
        new(code: Code::TIMER_CURRENT_VALUE, type: Type::WORD)
      end

      def self.timer_contact
        new(code: Code::TIMER_CONTACT, type: Type::BIT)
      end

      def self.timer_coil
        new(code: Code::TIMER_COIL, type: Type::BIT)
      end

      def self.counter_current_value
        new(code: Code::COUNTER_CURRENT_VALUE, type: Type::WORD)
      end

      def self.counter_contact
        new(code: Code::COUNTER_CONTACT, type: Type::BIT)
      end

      def self.counter_coil
        new(code: Code::COUNTER_COIL, type: Type::BIT)
      end

      def self.data_register
        new(code: Code::DATA_REGISTER, type: Type::WORD)
      end

      def self.link_register
        new(code: Code::LINK_REGISTER, type: Type::WORD)
      end

      def self.file_register
        new(code: Code::FILE_REGISTER, type: Type::WORD)
      end

      def bit?
        type == Type::BIT
      end

      def word?
        type == Type::WORD
      end

      def to_b
        code
      end

      private

      attr_reader :type

    end
  end
end
