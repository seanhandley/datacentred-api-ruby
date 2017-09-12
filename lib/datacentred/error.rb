module Datacentred
  # Behaviours and exceptions for recoverable errors.
  module Errors
    # Test server response and raise appropriate error if an error has been returned.
    #
    # @raise [Error] Appropriate error for server response code.
    # @return [nil] Returns nil on success
    def self.raise_unless_successful(status, body)
      return if status.to_s.start_with? "2" # 2xx
      err = errors[status]
      message = body&.fetch("errors")&.first&.fetch("detail")
      if err
        raise err, message || status.to_s
      else
        raise Error, "Error #{status}: #{message}"
      end
    end

    # Datacentred base error
    class Error < StandardError ; end

    # Raised when an entity cannot be located using the unique id specified.
    #
    # Corresponds to a HTTP 404 error.
    class NotFound < Error; end

    # Raised usually when data validations fail on operations that mutate state.
    #
    # Corresponds to a HTTP 422 error.
    class UnprocessableEntity < Error; end

    # Raised when credentials are invalid.
    #
    # Credentials may be invalid because they're incorrect, or because they correspond to an account
    # that does not have the correct permissions to access the API.
    #
    # Corresponds to a HTTP 403 error.
    class Unauthorized < Error; end

    private

    def self.errors
      {
        401 => Datacentred::Errors::Unauthorized,
        404 => Datacentred::Errors::NotFound,
        422 => Datacentred::Errors::UnprocessableEntity
      }
    end
  end
end
