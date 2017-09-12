module Datacentred
  module Request
    class Versions < Base

      def self.list
        get("/api")['versions']
      end
    end
  end
end
