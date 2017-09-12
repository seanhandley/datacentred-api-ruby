require_relative '../test_helper'

module Datacentred
  class AuthorizationIntegrationTest < Minitest::Test
    def test_account_not_authorized
      VCR.use_cassette "not_authorized" do
        assert_raises Errors::Unauthorized do
          Datacentred::Project.all
        end
      end
    end

    def test_manually_setting_credentials
      Datacentred.access_key = "foo"
      assert_equal "foo", Datacentred.access_key
      Datacentred.secret_key = "bar"
      assert_equal "bar", Datacentred.secret_key
    end

    def test_catch_all_error
      # VCR edited to return HTTP 418
      VCR.use_cassette "unexpected_error" do
        error = assert_raises Datacentred::Errors::Error do
          Datacentred::Project.all
        end
        assert_equal "Error 418: Im a teapot.", error.message
      end
    end
  end
end
