module Datacentred
  module Request
    API_BASE_URL = 'https://my.datacentred.io'

    class Base

      def self.get(url, payload=nil)
        response = Datacentred::Response.new(conn.get(url, payload))
        response.body
      end

      def self.post(url, payload=nil)
        response = Datacentred::Response.new(conn.post(url, payload))
        response.body
      end

      def self.put(url, payload=nil)
        response = Datacentred::Response.new(conn.put(url, payload))
        response.body
      end

      def self.delete(url, payload=nil)
        response = Datacentred::Response.new(conn.delete(url, payload))
        response.body
      end

      private

      def self.conn
        Faraday.new(:url => API_BASE_URL) do |faraday|
          faraday.path_prefix = "/api/"
          faraday.request  :url_encoded
          faraday.headers['Accept'] = "application/vnd.datacentred.api+json; version=1"
          faraday.headers['Authorization'] = "Token token=#{credentials}"
          faraday.headers['Content-Type'] = 'application/json'
          faraday.adapter  Faraday.default_adapter
        end
      end

      def self.credentials
        "#{Datacentred.access_key}:#{Datacentred.secret_key}"
      end

    end
  end
end
