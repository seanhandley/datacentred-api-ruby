module Datacentred
  # A response from the API server.
  class Response
    attr_reader :body, :status

    # A response from the API server, initialized with A Faraday HTTP Response.
    #
    # @param [Faraday::Response] server_response A response object returned from Faraday.
    # @raise [Errors::Error] Raised if response isn't a 2xx status code.
    def initialize(server_response)
      begin
        @body = JSON.parse server_response.body
      rescue JSON::ParserError
        @body = nil
      end
      @status = server_response.status
      Errors.raise_unless_successful(status, @body)
    end
  end
end
