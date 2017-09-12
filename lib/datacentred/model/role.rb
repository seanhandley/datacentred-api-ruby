module Datacentred
  module Model
    class Role < OpenStruct
      def initialize(params)
        params.delete("links")
        params["created_at"] = Time.parse params["created_at"]
        params["updated_at"] = Time.parse params["updated_at"]
        super(params)
      end

      # Create a new role
      #
      # Create a new role for users.
      #
      # @param [Hash] role role information
      # @raise [Datacentred::UnprocessableEntity] if role doesn't have valid permissions
      def self.create(params)
        new Request::Roles.create(params)
      end

      # List all available roles
      #
      # Show a list of all the roles.
      #
      # @return [[Datacentred::Model::Role]] a collection of all roles
      def self.all
        Request::Roles.list.map{|role| new(role) }
      end

      # Show a role
      #
      # Show the specified role
      #
      # @param [String] id the unique identifier for this role
      # @raise [Datacentred::NotFoundError] if role couldn't be found
      # @return [Datacentred::Model::Role] the role, if it exists
      def self.find(id)
        new Request::Roles.show(id)
      end

      # Update a role
      #
      # Update the specified role.
      #
      # @param [String] id the unique identifier for this role
      # @param [Hash] role role information
      # @raise [Datacentred::UnprocessableEntity] if role doesn't have valid permissions
      # @raise [Datacentred::NotFoundError] if role doesn't exist
      # @return [Datacentred::Model::Role] updated role
      def self.update(id, params)
        new Request::Roles.update(id, params)
      end

      # Delete a role
      #
      # Permanently remove the specified role.
      #
      # @param [String] id the unique identifier for this role
      # @raise [Datacentred::NotFoundError] if role couldn't be found
      # @raise [Datacentred::UnprocessableEntity] if role doesn't exist
      def self.delete(id)
        Request::Roles.destroy(id)
      end

      # List all members of this role
      #
      # Show a list of all the members assigned to this role.
      #
      # @param [String] id the unique identifier for this role
      # @return [Datacentred::Model::User] a collection of the role's members
      def self.users(id)
        Request::Roles.list_users(id).map{|user| new(user) }
      end

      # Add new member to this role
      #
      # Add a new member (user) to this role, giving them the associated permissions.
      #
      # @param [String] role_id the unique identifier for this role
      # @param [String] user_id the unique identifier for this user
      # @raise [Datacentred::NotFoundError] if role or user coundn't be found
      def self.add_user(role_id, user_id)
        Request::Roles.add_user(role_id, user_id)
      end

      # Remove member from this role
      #
      # Remove member (user) from this role, revoking the associated permissions.
      #
      # @param [String] role_id the unique identifier for this role
      # @param [String] user_id the unique identifier for this user
      # @raise [Datacentred::NotFoundError] if role or user coundn't be found
      def self.remove_user(role_id, user_id)
        Request::Roles.remove_user(role_id, user_id)
      end
    end
  end
end
