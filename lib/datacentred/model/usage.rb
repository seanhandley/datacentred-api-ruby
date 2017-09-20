module Datacentred
  module Model
    # Usage data for a given month/year.
    #
    # Data is updated every few hours for the current month.
    #
    # @attr [Time] last_updated_at
    # @attr [[Hash]] projects
    class Usage < Base
      # Retrieve account usage data for a given year/month.
      #
      # @param [Integer] year The year.
      # @param [Integer] month The month.
      # @raise [Errors::NotFound] Raised if no usage data found for
      #   given year/month pair.
      # @return [Usage] Usage for given year/month pair.
      def self.find(year, month)
        new Request::Usage.show year, month
      end
    end
  end
end
