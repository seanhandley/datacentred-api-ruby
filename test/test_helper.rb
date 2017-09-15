require 'coveralls'
Coveralls.wear!

ENV["RAILS_ENV"] = "test"
$VERBOSE = nil

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'test/vcr_cassettes'
  c.hook_into :webmock
end

require_relative '../lib/datacentred'

require 'webmock/minitest'
require 'minitest/autorun'
