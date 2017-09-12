require 'faraday'
require 'json'
require 'time'

module Datacentred
  require_relative 'datacentred/response'
  require_relative 'datacentred/error'
  require_relative 'datacentred/model/user'
  require_relative 'datacentred/model/project'
  require_relative 'datacentred/model/role'
  require_relative 'datacentred/model/usage'
  require_relative 'datacentred/model/version'
  require_relative 'datacentred/request/base'
  require_relative 'datacentred/request/projects'
  require_relative 'datacentred/request/users'
  require_relative 'datacentred/request/roles'
  require_relative 'datacentred/request/usage'
  require_relative 'datacentred/request/versions'

  # Set Datacentred account credentials
  #
  #
  # @raise [Datacentred::Unauthorized] if Token authentication failed, invalid credentials were given or API access is not authorized.

  # Set DATACENTRED_ACCESS environment variable value as access key
  def self.access_key
    @@access_key ||= ENV['DATACENTRED_ACCESS']
  end

  # Set access key manually as a given value
  def self.access_key=(val)
    @@access_key = val
  end

  # Set DATACENTRED_SECRET environment variable value as secret key
  def self.secret_key
    @@secret_key ||= ENV['DATACENTRED_SECRET']
  end

  # Set secret key manually as a given value
  def self.secret_key=(val)
    @@secret_key = val
  end

  User    = Model::User
  Project = Model::Project
  Role    = Model::Role
  Usage   = Model::Usage
  Version = Model::Version
end
