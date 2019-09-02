# frozen_string_literal: true

module McProtocolE
  module Frame3e
    # This class shows a device.
    class Device

      module Code
        SPECIAL_RELAY = "\x91".b
        SPECIAL_REGISTER = "\xA9".b
        INPUT = "\x9C".b
        OUTPUT = "\x9D".b
        INTERNAL_RELAY = "\x90".b
        LATCH_RELAY = "\x92".b
        ANNUNCIATOR = "\x93".b
        EDGE_RELAY = "\x94".b
        LINK_RELAY = "\xA0".b
        DATA_REGISTER = "\xA8".b
        LINK_REGISTER = "\xB4".b
        TIMER_CONTACT = "\xC1".b
        TIMER_COIL = "\xC0".b
        TIMER_CURRENT_VALUE = "\xC2".b
        RETENTIVE_TIMER_CONTACT = "\xC7".b
        RETENTIVE_TIMER_COIL = "\xC6".b
        RETENTIVE_TIMER_CURRENT_VALUE = "\xC8".b
        COUNTER_CONTACT = "\xC4".b
        COUNTER_COIL = "\xC3".b
        COUNTER_CURRENT_VALUE = "\xC5".b
        LINK_SPECIAL_RELAY = "\xA1".b
        LINK_SPECIAL_REGISTER = "\xB5".b
        DIRECT_ACCESS_INPUT = "\xA2".b
        DIRECT_ACCESS_OUTPUT = "\xA3".b
        INDEX_REGISTER = "\xCC".b
        FILE_REGISTER_BSM = "\xAF".b
        FILE_REGISTER_SNAM = "\xb0".b
        MODULE_ACCESS_DEVICE = "\xAB".b
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

      def self.special_relay
        new(code: Code::SPECIAL_RELAY, type: Type::BIT)
      end

      def self.special_register
        new(code: Code::SPECIAL_REGISTER, type: Type::WORD)
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

      def self.latch_relay
        new(code: Code::LATCH_RELAY, type: Type::BIT)
      end

      def self.annunciator
        new(code: Code::ANNUNCIATOR, type: Type::BIT)
      end

      def self.edge_relay
        new(code: Code::EDGE_RELAY, type: Type::BIT)
      end

      def self.link_relay
        new(code: Code::LINK_RELAY, type: Type::BIT)
      end

      def self.data_register
        new(code: Code::DATA_REGISTER, type: Type::WORD)
      end

      def self.link_register
        new(code: Code::LINK_REGISTER, type: Type::WORD)
      end

      def self.timer_contact
        new(code: Code::TIMER_CONTACT, type: Type::BIT)
      end

      def self.timer_coil
        new(code: Code::TIMER_COIL, type: Type::BIT)
      end

      def self.timer_current_value
        new(code: Code::TIMER_CURRENT_VALUE, type: Type::WORD)
      end

      def self.retentive_timer_contact
        new(code: Code::RETENTIVE_TIMER_CONTACT, type: Type::BIT)
      end

      def self.retentive_timer_coil
        new(code: Code::RETENTIVE_TIMER_COIL, type: Type::BIT)
      end

      def self.retentive_timer_current_value
        new(code: Code::RETENTIVE_TIMER_CURRENT_VALUE, type: Type::WORD)
      end

      def self.counter_contact
        new(code: Code::COUNTER_CONTACT, type: Type::BIT)
      end

      def self.counter_coil
        new(code: Code::COUNTER_COIL, type: Type::BIT)
      end

      def self.counter_current_value
        new(code: Code::COUNTER_CURRENT_VALUE, type: Type::WORD)
      end

      def self.link_special_relay
        new(code: Code::LINK_SPECIAL_RELAY, type: Type::BIT)
      end

      def self.link_special_register
        new(code: Code::LINK_SPECIAL_REGISTER, type: Type::WORD)
      end

      def self.direct_access_input
        new(code: Code::DIRECT_ACCESS_INPUT, type: Type::BIT)
      end

      def self.direct_access_output
        new(code: Code::DIRECT_ACCESS_OUTPUT, type: Type::BIT)
      end

      def self.index_register
        new(code: Code::INDEX_REGISTER, type: Type::WORD)
      end

      def self.file_register_bsm
        new(code: Code::FILE_REGISTER_BSM, type: Type::WORD)
      end

      def self.file_register_snam
        new(code: Code::FILE_REGISTER_SNAM, type: Type::BIT)
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
