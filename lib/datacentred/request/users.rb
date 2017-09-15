module Datacentred
  module Request
    # RESTful API requests for the user endpoints.
    class Users < Base
      class << self
        # Create a new user.
        #
        #   POST /api/users
        #
        # @param [Hash] params User attributes.
        # @raise [Errors::UnprocessableEntity] Raised if validations
        #   fail for the supplied attributes.
        # @raise [Errors::Unauthorized] Raised if credentials aren't valid.
        # @return [Hash] New user.
        def create(params)
          post('users', 'user' => params)['user']
        end

        # List all available users.
        #
        #   GET /api/users
        #
        # @raise [Errors::Unauthorized] Raised if credentials aren't valid.
        # @return [[Hash]] A collection of all users on this account.
        def list
          get('users')['users']
        end

        # Find a user by unique ID.
        #
        #   GET /api/users/82fa8de8f09102cc
        #
        # @param [String] id The unique identifier for this user.
        # @raise [Errors::NotFound] Raised if the user couldn't be found.
        # @raise [Errors::Unauthorized] Raised if credentials aren't valid.
        # @return [Hash] The user, if it exists.
        def show(id)
          get("users/#{id}")['user']
        end

        # Update a user by unique ID.
        #
        #   PUT /api/users/82fa8de8f09102cc
        #
        # @param [String] id The unique identifier for this user.
        # @param [Hash] params User attributes.
        # @raise [Errors::UnprocessableEntity] Raised if validations fail
        #   for the supplied attributes.
        # @raise [Errors::NotFound] Raised if the user couldn't be found.
        # @raise [Errors::Unauthorized] Raised if credentials aren't valid.
        # @return [Hash] The updated user.
        def update(id, params)
          put("users/#{id}", 'user' => params)['user']
        end

        # Permanently remove the specified user.
        #
        #   DELETE /api/users/82fa8de8f09102cc
        #
        # @param [String] id The unique identifier for this user.
        # @raise [Errors::NotFound] Raised if the user couldn't be found.
        # @raise [Errors::UnprocessableEntity] Raised if validations fail
        #   for the specified user.
        # @raise [Errors::Unauthorized] Raised if credentials aren't valid.
        # @return [nil] Confirms the user was destroyed.
        def destroy(id)
          delete("users/#{id}")
        end
      end
    end
  end
end
