module Datacentred
  module Request
    # RESTful API requests for the usage endpoints.
    class Usage < Base
      # Retrieve account usage data for a given year/month.
      #
      #   GET /api/usage/2017/9
      #
      # @param [Integer] year The year.
      # @param [Integer] month The month.
      # @raise [Errors::NotFound] Raised if no usage data found for
      #   given year/month pair.
      # @raise [Errors::Unauthorized] Raised if credentials aren't valid.
      # @return [Hash] Usage for given year/month pair.
      def self.show(year, month)
        get("usage/#{year}/#{month}")
      end
    end
  end
end
