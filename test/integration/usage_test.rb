require_relative '../test_helper'

module Datacentred
  class UsageIntegrationTest < Minitest::Test

    def test_show_usage
      VCR.use_cassette('show_usage') do
        @usage = Datacentred::Usage.show(2017, 07)
        assert @usage.is_a? Array
        assert @usage.first.name.is_a? String
        assert @usage.first.id.is_a? String
        assert @usage.first.usage.is_a? Hash
      end
    end

    def test_raises_not_found_if_no_data
      VCR.use_cassette('usage_not_found') do
        assert_raises(Datacentred::NotFoundError) do
          @usage = Datacentred::Usage.show(2010, 07)
        end
      end
    end
  end
end
