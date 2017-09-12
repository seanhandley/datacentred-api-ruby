module Datacentred
  module Model
    class Project < OpenStruct
      def initialize(params)
        params.delete("links") if params
        params["created_at"] = Time.parse params["created_at"]
        params["updated_at"] = Time.parse params["updated_at"]
        super(params)
      end

      # Create a new project
      #
      # Create a new DataCentred cloud project (backed by OpenStack).
      #
      # @param [Hash] project project information
      # @raise [Datacentred::UnprocessableEntity] if project name is already in use
      def self.create(params)
        new Request::Projects.create(params)
      end

      # List all available projects
      #
      # Show a list of all the projects.
      #
      # @return [[Datacentred::Model::Project]] a collection of all projects
      def self.all
        Request::Projects.list.map{ |project| new(project) }
      end

      # Show a project
      #
      # Show the specified project
      #
      # @param [String] id the unique identifier for this project
      # @raise [Datacentred::NotFoundError] if project couldn't be found
      # @return [Datacentred::Model::Project] the project, if it exists
      def self.find(id)
        new Request::Projects.show(id)
      end

      # Update a project
      #
      # Update the specified project
      #
      # @param [String] id the unique identifier for this project
      # @param [Hash] project project information
      # @raise [Datacentred::UnprocessableEntity] if project name is already in use
      # @raise [Datacentred::NotFoundError] if project couldn't be found
      # @return [Datacentred::Model::Project] updated project
      def self.update(id, params)
        new Request::Projects.update(id, params)
      end

      # Delete a project
      #
      # Permanently remove the specified project.
      #
      # @param [String] id the unique identifier for this project
      # @raise [Datacentred::NotFoundError] if project couldn't be found
      # @raise [Datacentred::UnprocessableEntity] if project doesn't exist
      def self.delete(id)
        Request::Projects.destroy(id)
      end

      # List all members of this project
      #
      # Show a list of all the members assigned to this project.
      #
      # @param [String] id the unique identifier for this project
      # @return [Datacentred::Model::User] a collection of the project's members
      def self.users(id)
        Request::Projects.list_users(id).map{ |user| new(user) }
      end

      # Add new member to this project
      #
      # Add a new member (user) to this project, giving them access to it via OpenStack.
      #
      # @param [String] project_id the unique identifier for this project
      # @param [String] user_id the unique identifier for this user
      # @raise [Datacentred::NotFoundError] if project or user couldn't be found
      def self.add_user(project_id, user_id)
        Request::Projects.add_user(project_id, user_id)
      end

      # Remove member from this project
      #
      # Remove member (user) from this project, revoking their access to it on OpenStack.
      #
      # @param [String] project_id the unique identifier for this project
      # @param [String] user_id the unique identifier for this user
      # @raise [Datacentred::NotFoundError] if project or user couldn't be found
      def self.remove_user(project_id, user_id)
        Request::Projects.remove_user(project_id, user_id)
      end
    end
  end
end
