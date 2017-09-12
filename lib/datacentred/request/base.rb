module Datacentred
  module Request
    # Base class for all API requests.
    #
    # Uses the Faraday library for HTTP interactions.
    class Base
      class << self
        # Access a resource via HTTP GET.
        #
        # @param [String] path Desired server path.
        # @raise [Errors::Error] Raised if the server returns a non 2xx error code.
        # @return [Object] Parsed server response body.
        def get(path)
          action :get, path
        end

        # Access a resource via HTTP POST.
        #
        # @param [String] path Desired server path.
        # @param [Object] payload JSON serializable object.
        # @raise [Errors::Error] Raised if the server returns a non 2xx error code.
        # @return [Object] Parsed server response body.
        def post(path, payload=nil)
          action :post, path, payload
        end

        # Access a resource via HTTP PUT.
        #
        # @param [String] path Desired server path.
        # @param [Object] payload JSON serializable object.
        # @raise [Errors::Error] Raised if the server returns a non 2xx error code.
        # @return [Object] Parsed server response body.
        def put(path, payload=nil)
          action :put, path, payload
        end

        # Access a resource via HTTP DELETE.
        #
        # @param [String] path Desired server path.
        # @raise [Errors::Error] Raised if the server returns a non 2xx error code.
        # @return [nil] Returns nil on success.
        def delete(path)
          action :delete, path
        end

        private

        def action(verb, path, payload=nil)
          params = [path, payload&.to_json].compact
          response = Datacentred::Response.new connection.send verb, *params
          response.body
        end

        def connection
          Faraday.new(url: base_url) do |faraday|
            faraday.request :url_encoded
            faraday.adapter Faraday.default_adapter
            faraday.headers['Accept']        = "#{accept_type}; version=#{api_version}"
            faraday.headers['Authorization'] = "Token token=#{credentials}"
            faraday.headers['Content-Type']  = "application/json"
            faraday.path_prefix              = "/api/"
          end
        end

        def accept_type
          "application/vnd.datacentred.api+json"
        end

        def api_version
          "1".freeze
        end

        def base_url
          "https://my.datacentred.io"
        end

        def credentials
          [Datacentred.access_key, Datacentred.secret_key].join ":"
        end
      end
    end
  end
end
