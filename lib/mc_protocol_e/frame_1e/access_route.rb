# frozen_string_literal: true

module McProtocolE
  module Frame1e
    # This class shows a access route.
    class AccessRoute

      OWN_PC_NUM = 255

      attr_reader :pc_num

      # Constructor.
      # @param [Integer] pc_num PC number
      def initialize(pc_num:)
        @pc_num = pc_num
      end

      # Returns instance of own station.
      # @return [AccessRoute] a access route to own station
      def self.own_station
        new(pc_num: OWN_PC_NUM)
      end

      # Returns binary string.
      # @return [String] binary string
      def to_b
        [pc_num].pack("v")[0]
      end

    end
  end
end
