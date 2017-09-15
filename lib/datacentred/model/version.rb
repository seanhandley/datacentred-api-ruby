module Datacentred
  module Model
    # An API version currently available for use.
    #
    #   This method does not require authentication.
    #
    # An API version may be:
    # * *CURRENT* - The latest supported version.
    # * *SUPPORTED* - A supported older version.
    # * *DEPRECATED* - Currently supported but soon to be retired.
    #
    # @attr [Integer] id
    # @attr [String] status
    class Version < Base
      # List all available API versions
      #
      # @return [[Version]] Currently available versions of the API.
      def self.all
        Request::Versions.list.map { |version| new version }
      end
    end
  end
end
