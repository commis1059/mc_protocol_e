#!/usr/bin/env ruby
# frozen_string_literal: true

require 'mc_protocol_e'
require 'optparse'

# Usage: ./mc_protocol_e.rb -h 192.168.1.250 -p 4000 -f 3e --rw r --device_num 3000 --device_points 16
opts = ARGV.getopts("h:p:f:", "rw:", "device_num:", "device_points:", "values:")
raise ArgumentError, "required option is not specified" unless %w[h p f device_num device_points].all? {|key| opts[key] }

req =
  case opts["f"]
  when "1e"
    case opts["rw"]
    when "r"
      McProtocolE::Frame1e::Request.batch_read_in_word(
        access_route: McProtocolE::Frame1e::AccessRoute.own_station,
        wait_sec: 3,
        device_range: McProtocolE::Frame1e::DeviceRange.data_register(device_num: opts["device_num"].to_i, device_points: opts["device_points"].to_i)
      )
    when "w"
      raise ArgumentError, "values is required" unless opts["values"]

      McProtocolE::Frame1e::Request.batch_write_in_word(
        access_route: McProtocolE::Frame1e::AccessRoute.own_station,
        wait_sec: 3,
        device_range: McProtocolE::Frame1e::DeviceRange.data_register(device_num: opts["device_num"].to_i, device_points: opts["device_points"].to_i),
        values: opts["values"].split(",").map(&:to_i),
        )
    else
      raise ArgumentError
    end
  when "3e"
    case opts["rw"]
    when "r"
      McProtocolE::Frame3e::Request.batch_read_in_word(
        access_route: McProtocolE::Frame3e::AccessRoute.own_station,
        wait_sec: 3,
        device_range: McProtocolE::Frame3e::DeviceRange.data_register(device_num: opts["device_num"].to_i, device_points: opts["device_points"].to_i)
      )
    when "w"
      raise ArgumentError, "values is required" unless opts["values"]

      McProtocolE::Frame3e::Request.batch_write_in_word(
        access_route: McProtocolE::Frame3e::AccessRoute.own_station,
        wait_sec: 3,
        device_range: McProtocolE::Frame3e::DeviceRange.data_register(device_num: opts["device_num"].to_i, device_points: opts["device_points"].to_i),
        values: opts["values"].split(",").map(&:to_i),
        )
    else
      raise ArgumentError
    end
  else
    raise ArgumentError
  end

McProtocolE::Client.start(address: opts["h"], port: opts["p"].to_i) {|client|
  pp req.to_b
  res = client.request(req)
  pp res.map {|raw| raw.unpack1("s") }
}
