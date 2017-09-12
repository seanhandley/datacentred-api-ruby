module Datacentred
  module Request
    class Usage < Base

      def self.show(year, month)
        get("usage/#{year}/#{month}")
      end
    end
  end
end
