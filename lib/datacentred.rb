require 'faraday'
require 'json'
require 'recursive-open-struct'
require 'time'

# Main Datacentred client module
#
# This library acts as a Ruby wrapper for the DataCentred API.
module Datacentred
  require_relative 'datacentred/error'
  require_relative 'datacentred/model/base'
  require_relative 'datacentred/model/project'
  require_relative 'datacentred/model/role'
  require_relative 'datacentred/model/usage'
  require_relative 'datacentred/model/user'
  require_relative 'datacentred/request/base'
  require_relative 'datacentred/request/projects'
  require_relative 'datacentred/request/roles'
  require_relative 'datacentred/request/usage'
  require_relative 'datacentred/request/users'
  require_relative 'datacentred/response'

  # Access key credential for the DataCentred API.
  #
  # This value is automatically loaded from the *DATACENTRED_ACCESS*
  # environment variable.
  #
  # You can find your API credentials by logging into the dashboard at
  # https://my.datacentred.io
  #
  # @return [String] API access key credential
  def self.access_key
    @access_key ||= ENV['DATACENTRED_ACCESS']
  end

  # Set a new access key value.
  #
  # This will override any values loaded from environment variables.
  #
  # @param [String] new_access_key New access key value
  # @return [String] API access key credential
  def self.access_key=(new_access_key)
    @access_key = new_access_key
  end

  # Secret key credential for the DataCentred API.
  #
  # This value is automatically loaded from the *DATACENTRED_SECRET*
  # environment variable.
  #
  # You can find your API credentials by logging into the dashboard
  # at https://my.datacentred.io
  #
  # @return [String] API secret key credential
  def self.secret_key
    @secret_key ||= ENV['DATACENTRED_SECRET']
  end

  # Set a new secret key value.
  #
  # This will override any values loaded from environment variables.
  #
  # @param [String] new_secret_key New secret key value
  #
  # @return [String] API secret key credential
  def self.secret_key=(new_secret_key)
    @secret_key = new_secret_key
  end

  # Shorthand alias for {Model::Project}
  # @see Model::Project
  class Project < Model::Project; end

  # Shorthand alias for {Model::Role}
  # @see Model::Role
  class Role < Model::Role; end

  # Shorthand alias for {Model::Usage}
  # @see Model::Usage
  class Usage < Model::Usage; end

  # Shorthand alias for {Model::User}
  # @see Model::User
  class User < Model::User; end

  # Model classes representing RESTful API entities.
  module Model; end

  # Request classes representing RESTful API interactions.
  module Request
  end
end
