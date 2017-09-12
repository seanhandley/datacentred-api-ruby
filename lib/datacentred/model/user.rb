module Datacentred
  module Model
    class User < OpenStruct
      def initialize(params)
        params.delete("links")
        params["created_at"] = Time.parse params["created_at"]
        params["updated_at"] = Time.parse params["updated_at"]
        super(params)
      end

      # Create a new user
      #
      # Create a new DataCentred user (backed by OpenStack).
      #
      # @param [Hash] user user information
      # @raise [Datacentred::UnprocessableEntity] if password is not provided
      def self.create(params)
        new Request::Users.create(params)
      end

      # List all available users
      #
      # Show a list of all the users.
      #
      # @param [Hash] user user information
      def self.all
        Request::Users.list.map { |user| new(user) }
      end

      # Show a user
      #
      # Show the specified user
      #
      # @param [String] id the unique identifier for this user
      # @raise [Datacentred::NotFoundError] if user couldn't be found
      # @return [Datacentred::Model::User] the user, if it exists
      def self.find(id)
        new Request::Users.show(id)
      end

      # Update a user
      #
      # Update the specified user.
      #
      # @param [String] id the unique identifier for this user
      # @param [Hash] user user information
      # @raise [Datacentred::UnprocessableEntity] if user name is already in use
      # @raise [Datacentred::NotFoundError] if user couldn't be found
      # @return [Datacentred::Model::User] updated user
      def self.update(id, params)
        new Request::Users.update(id, params)
      end

      # Delete a user
      #
      # Permanently remove the specified user.
      #
      # @param [String] id the unique identifier for this user
      # @raise [Datacentred::NotFoundError] if user couldn't be found
      # @raise [Datacentred::UnprocessableEntity] if try to delete current user
      def self.delete(id)
        Request::Users.destroy(id)
      end
    end
  end
end
