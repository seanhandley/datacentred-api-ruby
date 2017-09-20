module Datacentred
  module Model
    # A role on your DataCentred account.
    #
    # Roles allow simple setup of user permissions via the creation of roles,
    # then assigning those roles to users.
    #
    # @attr [String] id
    # @attr [String] name
    # @attr [Boolean] admin
    # @attr [[String]] permissions
    # @attr_reader [Time] created_at
    # @attr_reader [Time] updated_at
    class Role < Base
      class << self
        # Create a new role.
        #
        # @param [Hash] params Role attributes.
        # @raise [Errors::UnprocessableEntity] Raised if validations fail
        #   for the supplied attributes.
        # @return [Role] New role.
        def create(params)
          new Request::Roles.create params
        end

        # List all available roles.
        #
        # @return [[Role]] A collection of all roles on this account.
        def all
          Request::Roles.list.map { |role| new role }
        end

        # Find a role by unique ID.
        #
        # @param [String] id The unique identifier for this role.
        # @raise [Errors::NotFound] Raised if the role couldn't be found.
        # @return [Role] The role, if it exists.
        def find(id)
          new Request::Roles.show id
        end

        # Update a role by unique ID.
        #
        # @param [String] id The unique identifier for this role.
        # @param [Hash] params Role attributes.
        # @raise [Errors::UnprocessableEntity] Raised if validations fail
        #   for the supplied attributes.
        # @raise [Errors::NotFound] Raised if the role doesn't exist.
        # @return [Role] The updated role.
        def update(id, params)
          new Request::Roles.update id, params
        end

        # Permanently remove the specified role.
        #
        # @param [String] id The unique identifier for this role.
        # @raise [Errors::NotFound] Raised if the role couldn't be found.
        # @raise [Errors::UnprocessableEntity] Raised if validations fail
        #   for the specifed role.
        # @return [Boolean] Confirms the role was destroyed.
        def destroy(id)
          Request::Roles.destroy id
          true
        end

        # List all users assigned to this role.
        #
        # @param [String] id The unique identifier for this role.
        # @return [[User]] A collection of the role's users.
        def users(id)
          Request::Roles.list_users(id).map { |user| new user }
        end

        # Add new user to this role, giving them the associated permissions.
        #
        # @param [String] role_id The unique identifier for this role.
        # @param [String] user_id The unique identifier for this user.
        # @raise [Errors::NotFound] Raised if the role or user couldn't be found.
        # @return [Boolean] Confirms that user was added (or is already present).
        def add_user(role_id:, user_id:)
          Request::Roles.add_user role_id, user_id
          true
        end

        # Remove user from this role, revoking the associated permissions.
        #
        # @param [String] role_id The unique identifier for this role.
        # @param [String] user_id The unique identifier for this user.
        # @raise [Errors::NotFound] Raised if the role or user coundn't be found.
        # @return [Boolean] Confirms that user was removed (or is already absent).
        def remove_user(role_id:, user_id:)
          Request::Roles.remove_user role_id, user_id
          true
        end
      end # class << self

      # Save any attribute changes to this role.
      #
      # @return [Boolean] Confirms that the changes are saved.
      def save
        Role.update id, to_h
        true
      end

      # Destroy this role.
      #
      # @return [Boolean] Confirms that the role is destroyed.
      def destroy
        Role.destroy id
        true
      end

      # List all users assigned to this role.
      #
      # @return [[User]] A collection of the role's users.
      def users
        Role.users id
      end

      # Add new user to this role, giving them the associated permissions.
      #
      # @param [User] user The user model to add.
      # @return [Boolean] Confirms that user was added (or is already present).
      def add_user(user)
        Role.add_user role_id: id, user_id: user.id
      end

      # Remove user from this role, revoking the associated permissions.
      #
      # @param [User] user The user model to remove.
      # @return [Boolean] Confirms that user was removed (or is already absent).
      def remove_user(user)
        Role.remove_user role_id: id, user_id: user.id
      end
    end
  end
end
