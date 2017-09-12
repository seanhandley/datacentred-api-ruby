module Datacentred
  module Model
    class Version < OpenStruct
      def initialize(params)
        params.delete("links")
        super(params)
      end

      # List all available API versions
      #
      # This endpoint shows all currently supported API versions, including information on their status. An API version may be:
      # * `CURRENT`
      #  * The latest supported version.
      # * `SUPPORTED`
      #  *  A supported older version.
      # * `DEPRECATED`
      #  * Currently supported but soon to be retired.
      #
      # This resource does not require authentication.
      #
      # @return [Datacentred::Model::Version] versions
      def self.all
        Request::Versions.list.map { |version| new(version) }
      end
    end
  end
end
