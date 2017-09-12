module Datacentred
  module Model
    class Usage < OpenStruct
      def initialize(params)
        params.delete("links")
        # params["last_updated_at"] = Time.parse params["last_updated_at"]
        super(params)
      end
      # Get usage data
      #
      # @param [Integer] year the year
      # @param [Integer] month the month
      # @raise [Datacentred::NotFoundError] if no usage data found for given year/month pair
      # @return [Datacentred::Model::Usage] usage for given year/month pair
      def self.show(year, month)
        Request::Usage.show(year, month)["projects"].map{ |project| new(project) }
      end
    end
  end
end
