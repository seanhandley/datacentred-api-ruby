module Datacentred
  module Model
    # A user on your DataCentred account.
    #
    # Users are team members with the ability to log into your DataCentred account.
    #
    # All users created in your DataCented account are backed by a
    # corresponding user in OpenStack's identity service (Keystone).
    class User < Base
      class << self
        # Create a new user.
        #
        # @param [Hash] params User attributes.
        # @raise [Errors::UnprocessableEntity] Raised if validations fail
        #   for the supplied attributes.
        # @raise [Errors::Unauthorized] Raised if credentials aren't valid.
        # @return [User] New user.
        def create(params)
          new Request::Users.create params
        end

        # List all available users.
        #
        # @raise [Errors::Unauthorized] Raised if credentials aren't valid.
        # @return [[User]] A collection of all users on this account.
        def all
          Request::Users.list.map { |user| new user }
        end

        # Find a user by unique ID.
        #
        # @param [String] id The unique identifier for this user.
        # @raise [Errors::NotFound] Raised if the user couldn't be found.
        # @raise [Errors::Unauthorized] Raised if credentials aren't valid.
        # @return [User] The user, if it exists.
        def find(id)
          new Request::Users.show id
        end

        # Update a user by unique ID.
        #
        # @param [String] id The unique identifier for this user.
        # @param [Hash] params User attributes.
        # @raise [Errors::UnprocessableEntity] Raised if validations fail
        #   for the supplied attributes.
        # @raise [Errors::NotFound] Raised if the user couldn't be found.
        # @raise [Errors::Unauthorized] Raised if credentials aren't valid.
        # @return [User] The updated user.
        def update(id, params)
          new Request::Users.update id, params
        end

        # Permanently remove the specified user.
        #
        # @param [String] id The unique identifier for this user.
        # @raise [Errors::NotFound] Raised if the user couldn't be found.
        # @raise [Errors::UnprocessableEntity] Raised if validations fail
        #   for the specified user.
        # @raise [Errors::Unauthorized] Raised if credentials aren't valid.
        # @return [Boolean] Confirms the user was destroyed.
        def destroy(id)
          Request::Users.destroy id
          true
        end
      end
    end
  end
end
