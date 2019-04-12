# McProtocolE

McProtocolE is an implementation of MC protocol client over ethernet by Ruby. MC protocol is communication protocol to access MELSEC (PLC). See below for details.

https://dl.mitsubishielectric.com/dl/fa/document/manual/plc/sh080008/sh080008x.pdf

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mc_protocol_e'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mc_protocol_e

## Example
Below is an example of use for this library.

```ruby
require 'optparse'
require_relative 'frame_1e/request'
require_relative 'frame_1e/access_route'
require_relative 'frame_1e/device_range'
require_relative 'frame_3e/request'
require_relative 'frame_3e/access_route'
require_relative 'frame_3e/device_range'

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
  pp res.map {|raw| raw.unpack("s").first }
}

```

## Limitations

* Support only TCP.
* Support only binary code.
* Support only below frames.
    * 3E frame
    * 1E frame
* Support only below commands.
    * Batch read in word units (0401)
    * Batch write in word units (1401)

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
