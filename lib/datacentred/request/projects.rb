module Datacentred
  module Request
    class Projects < Base

      def self.create(payload={})
        post('projects', payload.to_json)['project']
      end

      def self.list
        get('projects')['projects']
      end

      def self.show(id)
        get("projects/#{id}")['project']
      end

      def self.update(id, payload={})
        put("projects/#{id}", payload.to_json)['project']
      end

      def self.destroy(id)
        delete("projects/#{id}")
      end

      def self.list_users(id)
        get("projects/#{id}/users")['users']
      end

      def self.add_user(project_id, user_id)
        put("projects/#{project_id}/users/#{user_id}")
      end

      def self.remove_user(project_id, user_id)
        delete("projects/#{project_id}/users/#{user_id}")
      end
    end
  end
end
