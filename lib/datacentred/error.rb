module Datacentred
  class Error < StandardError
    def self.raise_unless_successful(status, body)
      return if status.to_s.start_with? "2" # 2xx
      err = Datacentred::errors[status]
      message = body&.fetch("errors")&.first&.fetch("detail")
      if err
        raise err, message
      else
        raise Datacentred::Error, "Error #{status}: #{message}"
      end
    end
  end

  class NotFoundError < StandardError; end
  class UnprocessableEntity < StandardError; end
  class Unauthorized < StandardError; end

  private

  def self.errors
    {
      401 => Unauthorized,
      404 => NotFoundError,
      422 => UnprocessableEntity
    }
  end
end
