module Datacentred
  module Request
    class Users < Base

      def self.create(payload={})
        post('users', payload.to_json)['user']
      end

      def self.list
        get('users')['users']
      end

      def self.show(id)
        get("users/#{id}")['user']
      end

      def self.update(id, payload)
        put("users/#{id}", payload.to_json)['user']
      end

      def self.destroy(id)
        delete("users/#{id}")
      end
    end
  end
end
