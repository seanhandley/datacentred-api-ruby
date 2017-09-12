require_relative '../test_helper'

module Datacentred
  class VersionsIntegrationTest < Minitest::Test
    def test_show_version
      VCR.use_cassette('show_version') do
        @versions = Datacentred::Version.all
        assert @versions.is_a? Array
        assert_equal @versions.first.id, "1"
        assert_equal @versions.first.status, "CURRENT"
      end
    end
  end
end
