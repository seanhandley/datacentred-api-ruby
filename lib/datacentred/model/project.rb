module Datacentred
  module Model
    # A project on your DataCentred account.
    #
    # Projects (also called "Cloud Projects" or "Tenants") are a way
    # of grouping together users and resources.
    #
    # All projects created in your DataCented account are backed by
    # a corresponding project in OpenStack's identity service (Keystone).
    #
    # @attr [String] id
    # @attr [String] name
    # @attr [Hash] quota_set
    # @attr_reader [Time] created_at
    # @attr_reader [Time] updated_at
    class Project < Base
      class << self
        # Create a new project.
        #
        # @param [Hash] params Project attributes
        # @raise [Errors::UnprocessableEntity] Raised if validations fail
        #   for the supplied attributes.
        # @return [Project] New project.
        def create(params)
          new Request::Projects.create params
        end

        # List all available projects.
        #
        # @return [[Project]] A collection of all projects on this account.
        def all
          Request::Projects.list.map { |project| new project }
        end

        # Find a project by unique ID.
        #
        # @param [String] id The unique identifier for this project.
        # @raise [Errors::NotFound] Raised if the project couldn't be found.
        # @return [Project] The project, if it exists.
        def find(id)
          new Request::Projects.show id
        end

        # Update a project by unique ID.
        #
        # @param [String] id The unique identifier for this project.
        # @param [Hash] params Project attributes.
        # @raise [Errors::UnprocessableEntity] Raised if validations fail
        #   for the supplied attributes.
        # @raise [Errors::NotFound] Raised if the project could not be found.
        # @return [Project] The updated project.
        def update(id, params)
          new Request::Projects.update id, params
        end

        # Permanently remove the specified project.
        #
        # @param [String] id The unique identifier for this project.
        # @raise [Errors::NotFound] Raised if the project couldn't be found.
        # @raise [Errors::UnprocessableEntity] Raised if validations fail
        #   for the specified project.
        # @return [Boolean] Confirms the user was destroyed.
        def destroy(id)
          Request::Projects.destroy id
          true
        end

        # List all users assigned to this project.
        #
        # @param [String] id The unique identifier for this project.
        # @return [[User]] A collection of the project's users.
        def users(id)
          Request::Projects.list_users(id).map { |user| new user }
        end

        # Add a new user to this project, giving them access to it via OpenStack.
        #
        # @param [String] project_id The unique identifier for this project.
        # @param [String] user_id The unique identifier for this user.
        # @raise [Errors::NotFound] Raised if the project or user couldn't be found.
        # @return [Boolean] Confirms the user was added (or is already present).
        def add_user(project_id:, user_id:)
          Request::Projects.add_user project_id, user_id
          true
        end

        # Remove user from this project, revoking their access to it on OpenStack.
        #
        # @param [String] project_id The unique identifier for this project.
        # @param [String] user_id The unique identifier for this user.
        # @raise [Errors::NotFound] Raised if project or user couldn't be found.
        # @return [Boolean] Confirms that user was removed (or is already absent).
        def remove_user(project_id:, user_id:)
          Request::Projects.remove_user project_id, user_id
          true
        end
      end # class << self

      # Save any attribute changes to this project.
      #
      # @return [Boolean] Confirms that the changes are saved.
      def save
        Project.update id, to_h
        true
      end

      # Destroy this project.
      #
      # @return [Boolean] Confirms that the project is destroyed.
      def destroy
        Project.destroy id
        true
      end

      # List all users assigned to this project.
      #
      # @return [[User]] A collection of the project's users.
      def users
        Project.users id
      end

      # Add new user to this project.
      #
      # @param [User] user The user model to add.
      # @return [Boolean] Confirms that user was added (or is already present).
      def add_user(user)
        Project.add_user project_id: id, user_id: user.id
      end

      # Remove user from this project.
      #
      # @param [User] user The user model to remove.
      # @return [Boolean] Confirms that user was removed (or is already absent).
      def remove_user(user)
        Project.remove_user project_id: id, user_id: user.id
      end
    end
  end
end
