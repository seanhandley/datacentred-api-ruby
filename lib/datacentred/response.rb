module Datacentred
  class Response

    attr_reader :body, :status

    def initialize(server_response)
      @body = JSON.parse server_response.body rescue nil
      @status = server_response.status
      Error.raise_unless_successful(status, @body)
    end
  end
end
