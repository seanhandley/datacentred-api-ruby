module Datacentred
  module Request
    class Roles < Base

      def self.create(payload={})
        post('roles', payload.to_json)['role']
      end

      def self.list
        get('roles')['roles']
      end

      def self.show(id)
        get("roles/#{id}")['role']
      end

      def self.update(id, payload={})
        put("roles/#{id}", payload.to_json)['role']
      end

      def self.destroy(id)
        delete("roles/#{id}")
      end

      def self.list_users(role_id)
        get("roles/#{role_id}/users")['users']
      end

      def self.add_user(role_id, user_id)
        put("roles/#{role_id}/users/#{user_id}")
      end

      def self.remove_user(role_id, user_id)
        delete("roles/#{role_id}/users/#{user_id}")
      end
    end
  end
end
