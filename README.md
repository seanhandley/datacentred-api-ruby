![Datacentred](https://assets-cdn.datacentred.io/assets/DC_Mono_B-903aac5ca4f5c6887193d880dbd1196deb8a978027eef5cb32de78b66d085935.png)

Ruby client library for automating DataCentred account management.

[www.datacentred.co.uk](https://www.datacentred.co.uk)

[![CircleCI](https://circleci.com/gh/datacentred/datacentred-api-ruby.svg?style=svg&circle-token=c284db6421742dcfe8c50f52945c31d9b976effb)](https://circleci.com/gh/datacentred/datacentred-api-ruby)
[![Gem Version](https://badge.fury.io/rb/datacentred.png)](http://badge.fury.io/rb/keybase-core)

# Installation

```
gem install datacentred
```

or

(in Gemfile or .gemspec)
```ruby
gem 'datacentred'
```

then

```ruby
require 'datacentred'
```

# Usage

This API allows you to automate operations against your DataCentred account.

Operations include:

* Creating and managing users;
* Creating and managing roles for users;
* Managing OpenStack Project creation, quota adjustments, and user assignments;
* Viewing detailed usage/billing information for your account.

## Authentication

The API uses two pieces of information to authenticate access.

A unique access key specific to your DataCentred account, and a secret key which is generated once.

To get started:

1. Find your API access key and secret key at [my.datacentred.io](https://my.datacentred.io)

![API Credentials](https://user-images.githubusercontent.com/98526/30334767-79f4617c-97d8-11e7-962c-ec3115d13896.png)

2. Set your credentials by exporting your access key and secret key as environment variables:

```
export DATACENTRED_ACCESS="my_access"
export DATACENTRED_SECRET="my_secret"
```

Or setting your keys manually using the following methods:

```ruby
Datacentred.access_key = 'my_access'
Datacentred.secret_key = 'my_secret'
```

NOTE: If you use this approach, the gem will ignore any values assigned to the environment variables.

## Usage Examples

The `User`, `Project`, and `Role` entities all support CRUD operations via the following methods:

* `.all` - returns an index of all entities of this type.
* `.create params` - creates a new entity where `params` is a hash of properties.
* `.update id, params` - updates the entity identified by `id` with the hash of properties defined by `params`.
* `.find id` - finds the entity via the unique identifier `id`.
* `.destroy id` - removes the entity via the unique identifier `id`.

Here are some worked examples:

### List all available users

```ruby
Datacentred::User.all
# => [#<Datacentred::Model::User id="2bd21ee25cde40fdb9454954e4fbb4b5", ...>, ...]
```

### Find a user by id

```ruby
Datacentred::User.find "2bd21ee25cde40fdb9454954e4fbb4b5"
# => #<Datacentred::Model::User id="2bd21ee25cde40fdb9454954e4fbb4b5", ...>
```

### Update a project

```ruby
Datacentred::Project.update "6d5277716c4b10d2177814af50b77175", name: "Foo"
# => #<Datacentred::Model::Project id="6d5277716c4b10d2177814af50b77175", name= "Foo", ...>
```

### Create a role

Acceptable permissions are: 'api.read', 'cloud.read', 'roles.modify', 'roles.read', 'storage.read', 'tickets.modify', 'usage.read'.

```ruby
Datacentred::Role.create name: "foo", permissions: ["usage.read"]
# => #<Datacentred::Model::Role id="654f423e-646a-4742-849d-d8c9ab9b4f39", name="foo", admin=false, permissions=["usage.read"] ...>
```

### Add a user to a role

```ruby
Datacentred::Role.add_user role_id: "654f423e-646a-4742-849d-d8c9ab9b4f39", user_id: "2bd21ee25cde40fdb9454954e4fbb4b5"
# => true
```

### Remove a user from a project

```ruby
Datacentred::Project.remove_user project_id: "6d5277716c4b10d2177814af50b77175", user_id: "2bd21ee25cde40fdb9454954e4fbb4b5"
# => true
```

### Get usage data for a given year and month

Usage data is returned simply by supplying a year and a month. If the year/month are current then the data will be as recent as the time contained within the `last_updated_at` property.

```ruby
@usage = Datacentred::Usage.find 2017, 6
# => #<Datacentred::Model::Usage last_updated_at=2017-07-12 09:46:54 UTC, projects=[{:id=>"37033518a4514f12adeb8346ac3f188c"
@usage.projects.first.name
# => "wyld_stallyns"
@usage.projects.first.usage.instances.first.current_flavor.name
=> "dc1.1x1"
```

## Schemas

There are JSON schemas available for each entity in the gem:

* Projects: https://my.datacentred.io/api/schemas/project
* Roles: https://my.datacentred.io/api/schemas/role
* Usage: https://my.datacentred.io/api/schemas/usage
* User: https://my.datacentred.io/api/schemas/user

## Errors

The gem may raise the following standard errors:

* `Unauthorized` - Your credentials are incorrect or your account isn't authorized for API access.
* `NotFound` - The entity you referred to can't be found with the ID you supplied.
* `UnprocessableEntity` - There was a validation issue with your request (only applies to create/delete/update operations)

## Documentation

Full documentation is also available via https://datacentred.github.io/datacentred-api-ruby/

## API Reference Manual

Please check out the [DataCentred API Documentation](https://my.datacentred.io/api/docs/v1) for a comprehensive description of the API itself.
