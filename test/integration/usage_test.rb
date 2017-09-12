require_relative '../test_helper'

module Datacentred
  class UsageIntegrationTest < Minitest::Test
    def test_show_usage
      VCR.use_cassette('show_usage') do
        @usage = Datacentred::Usage.find(2017, 07)
        assert @usage.last_updated_at.is_a? Time
        assert @usage.projects.is_a? Array
        assert @usage.projects.first.name.is_a? String
        assert @usage.projects.first.id.is_a? String
        assert_equal 0, @usage.projects.first.usage.ips.usage.first.value
      end
    end

    def test_raises_not_found_if_no_data
      VCR.use_cassette('usage_not_found') do
        assert_raises(Datacentred::Errors::NotFound) do
          @usage = Datacentred::Usage.find(2010, 07)
        end
      end
    end
  end
end
