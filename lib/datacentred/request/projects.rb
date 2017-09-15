module Datacentred
  module Request
    # RESTful API requests for the projects endpoints.
    class Projects < Base
      class << self
        # Create a new project.
        #
        #   POST /api/projects
        #
        # @param [Hash] params Project attributes.
        # @raise [Errors::UnprocessableEntity] Raised if validations fail
        #   for the supplied attributes.
        # @raise [Errors::Unauthorized] Raised if credentials aren't valid.
        # @return [Hash] New project.
        def create(params)
          post('projects', 'project' => params)['project']
        end

        # List all available projects.
        #
        #   GET /api/projects
        #
        # @raise [Errors::Unauthorized] Raised if credentials aren't valid.
        # @return [[Hash]] A collection of all projects on this account.
        def list
          get('projects')['projects']
        end

        # Find a project by unique ID.
        #
        #   GET /api/projects/ead738d9f894bed9
        #
        # @param [String] id The unique identifier for this project.
        # @raise [Errors::NotFound] Raised if the project couldn't be found.
        # @raise [Errors::Unauthorized] Raised if credentials aren't valid.
        # @return [Hash] The project, if it exists.
        def show(id)
          get("projects/#{id}")['project']
        end

        # Update a project by unique ID.
        #
        #   PUT /api/projects/ead738d9f894bed9
        #
        # @param [String] id The unique identifier for this project.
        # @param [Hash] params Project attributes.
        # @raise [Errors::UnprocessableEntity] Raised if validations fail
        #   for the supplied attributes.
        # @raise [Errors::NotFound] Raised if the project could not be found.
        # @raise [Errors::Unauthorized] Raised if credentials aren't valid.
        # @return [Hash] The updated project.
        def update(id, params)
          put("projects/#{id}", 'project' => params)['project']
        end

        # Permanently remove the specified project.
        #
        #   DELETE /api/projects/ead738d9f894bed9
        #
        # @param [String] id The unique identifier for this project.
        # @raise [Errors::NotFound] Raised if the project couldn't be found.
        # @raise [Errors::UnprocessableEntity] Raised if validations fail
        #   for the specified project.
        # @raise [Errors::Unauthorized] Raised if credentials aren't valid.
        # @return [nil] Confirms the user was destroyed.
        def destroy(id)
          delete("projects/#{id}")
        end

        # List all users assigned to this project.
        #
        #   GET /api/projects/ead738d9f894bed9/users
        #
        # @param [String] id The unique identifier for this project.
        # @raise [Errors::Unauthorized] Raised if credentials aren't valid.
        # @return [[Hash]] A collection of the project's users.
        def list_users(id)
          get("projects/#{id}/users")['users']
        end

        # Add a new user to this project, giving them access to it via OpenStack.
        #
        #   PUT /api/projects/ead738d9f894bed9/users/82fa8de8f09102cc
        #
        # @param [String] project_id The unique identifier for this project.
        # @param [String] user_id The unique identifier for this user.
        # @raise [Errors::NotFound] Raised if the project or user couldn't be found.
        # @raise [Errors::Unauthorized] Raised if credentials aren't valid.
        # @return [nil] Confirms the user was added (or is already present).
        def add_user(project_id, user_id)
          put("projects/#{project_id}/users/#{user_id}")
        end

        # Remove user from this project, revoking their access to it on OpenStack.
        #
        #   DELETE /api/projects/ead738d9f894bed9/users/82fa8de8f09102cc
        #
        # @param [String] project_id The unique identifier for this project.
        # @param [String] user_id The unique identifier for this user.
        # @raise [Errors::NotFound] Raised if project or user couldn't be found.
        # @raise [Errors::Unauthorized] Raised if credentials aren't valid.
        # @return [nil] Confirms that user was removed (or is already absent).
        def remove_user(project_id, user_id)
          delete("projects/#{project_id}/users/#{user_id}")
        end
      end
    end
  end
end
