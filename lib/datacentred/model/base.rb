module Datacentred
  module Model
    # Base class for all API models.
    #
    # Uses Recursive Structs to allow nested property access.
    class Base < RecursiveOpenStruct
      # Instantiate a new model object.
      #
      # @param [Hash] params Object properties as returned by the API.
      def initialize(params, _opts = nil)
        params.delete 'links' if params['links']

        %w(created_at updated_at last_updated_at).each do |key|
          params[key] = Time.parse(params[key]) if params[key]
        end

        super params, recurse_over_arrays: true
      end
    end
  end
end
