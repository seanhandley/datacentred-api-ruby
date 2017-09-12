require_relative '../lib/datacentred'
require 'json'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'test/vcr_cassettes'
  c.hook_into :webmock
end

TEST_ENV = true

require 'rubygems'
gem "minitest"
require 'minitest/autorun'
