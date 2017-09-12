module Datacentred
  module Request
    # RESTful API requests for the roles endpoints.
    class Roles < Base
      class << self
        # Create a new role.
        #
        #   POST /api/roles
        #
        # @param [Hash] params Role attributes.
        # @raise [Errors::UnprocessableEntity] Raised if validations fail for the supplied attributes.
        # @raise [Errors::Unauthorized] Raised if credentials aren't valid.
        # @return [Hash] New role.
        def create(params)
          post('roles', 'role' => params)['role']
        end

        # List all available roles.
        #
        #   GET /api/roles
        #
        # @raise [Errors::Unauthorized] Raised if credentials aren't valid.
        # @return [[Hash]] A collection of all roles on this account.
        def list
          get('roles')['roles']
        end

        # Find a role by unique ID.
        #
        #   GET /api/roles/ea894bed9d738d9f
        #
        # @param [String] id The unique identifier for this role.
        # @raise [Errors::NotFound] Raised if the role couldn't be found.
        # @raise [Errors::Unauthorized] Raised if credentials aren't valid.
        # @return [Hash] The role, if it exists.
        def show(id)
          get("roles/#{id}")['role']
        end

        # Update a role by unique ID.
        #
        #   PUT /api/roles/ea894bed9d738d9f
        #
        # @param [String] id The unique identifier for this role.
        # @param [Hash] params Role attributes.
        # @raise [Errors::UnprocessableEntity] Raised if validations fail for the supplied attributes.
        # @raise [Errors::NotFound] Raised if the role doesn't exist.
        # @raise [Errors::Unauthorized] Raised if credentials aren't valid.
        # @return [Hash] The updated role.
        def update(id, params)
          put("roles/#{id}", 'role' => params)['role']
        end

        # Permanently remove the specified role.
        #
        #   DELETE /api/roles/ea894bed9d738d9f
        #
        # @param [String] id The unique identifier for this role.
        # @raise [Errors::NotFound] Raised if the role couldn't be found.
        # @raise [Errors::UnprocessableEntity] Raised if validations fail for the specifed role.
        # @raise [Errors::Unauthorized] Raised if credentials aren't valid.
        # @return [nil] Confirms the role was destroyed.
        def destroy(id)
          delete("roles/#{id}")
        end

        # List all users assigned to this role.
        #
        #   GET /api/roles/ea894bed9d738d9f/users
        #
        # @param [String] role_id The unique identifier for this role.
        # @raise [Errors::Unauthorized] Raised if credentials aren't valid.
        # @return [[Hash]] A collection of the role's users.
        def list_users(role_id)
          get("roles/#{role_id}/users")['users']
        end

        # Add new user to this role, giving them the associated permissions.
        #
        #   PUT /api/roles/ea894bed9d738d9f/users/82fa8de8f09102cc
        #
        # @param [String] role_id The unique identifier for this role.
        # @param [String] user_id The unique identifier for this user.
        # @raise [Errors::NotFound] Raised if the role or user couldn't be found.
        # @raise [Errors::Unauthorized] Raised if credentials aren't valid.
        # @return [nil] Confirms that user was added (or is already present).
        def add_user(role_id, user_id)
          put("roles/#{role_id}/users/#{user_id}")
        end

        # Remove user from this role, revoking the associated permissions.
        #
        #   DELETE /api/roles/ea894bed9d738d9f/users/82fa8de8f09102cc
        #
        # @param [String] role_id The unique identifier for this role.
        # @param [String] user_id The unique identifier for this user.
        # @raise [Errors::NotFound] Raised if the role or user coundn't be found.
        # @raise [Errors::Unauthorized] Raised if credentials aren't valid.
        # @return [nil] Confirms that user was removed (or is already absent).
        def remove_user(role_id, user_id)
          delete("roles/#{role_id}/users/#{user_id}")
        end
      end
    end
  end
end
