module Datacentred
  module Request
    # RESTful API requests for the versions endpoint.
    #
    #   This model does not require authentication.
    #
    # An API version may be:
    # * *CURRENT* - The latest supported version.
    # * *SUPPORTED* - A supported older version.
    # * *DEPRECATED* - Currently supported but soon to be retired.
    class Versions < Base
      # List all available API versions
      #
      #   GET /api
      #
      # @return [[Hash]] Currently available versions of the API.
      def self.list
        get('/api')['versions']
      end
    end
  end
end
