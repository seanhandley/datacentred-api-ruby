![Datacentred](https://assets-cdn.datacentred.io/assets/DC_Mono_B-903aac5ca4f5c6887193d880dbd1196deb8a978027eef5cb32de78b66d085935.png)

Gem wrapper for [my.datacentred.io](https://my.datacentred.io) API.

[![CircleCI](https://circleci.com/gh/datacentred/datacentred-api-ruby.svg?style=svg&circle-token=c284db6421742dcfe8c50f52945c31d9b976effb)](https://circleci.com/gh/datacentred/datacentred-api-ruby)
[![Gem Version](https://badge.fury.io/rb/datacentred.png)](http://badge.fury.io/rb/keybase-core)

## TO DO BEFORE RELEASE

* [x] Remove sensitive data from history
* [ ] Code review
* [ ] Doc review (plus upload to rubydoc.org)

## Installing

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

## Usage

This API allows you to automate operations against your DataCentred account.

Operations include:

* Creating and managing users;
* Creating and managing roles for users;
* Managing OpenStack Project creation, quota adjustments, and user assignments;
* Viewing detailed usage/billing information for your account.
* If you have any questions or need any help, please [raise a support ticket!](https://my.datacentred.io/account/tickets)


### Authentication

The API uses two pieces of information to authenticate access.

A unique access key specific to your DataCentred account;
A secret key which is generated once.

To get started:

1. Grab your API access key and secret key via my.datacentred.io

<!--  Image example -->

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

This will override existing environment variables values.


### Users

  * List all available users

```ruby
Datacentred::User.all
```

Will return a list of all members of this account:

```json
{
  "users": [
    {
      "created_at": "2017-02-01T16:20:00Z",
      "email": "bill.s.preston@bodacious.com",
      "first_name": "Bill S.",
      "id": "293c38b7ec52c355414c6e975cde882f",
      "last_name": "Preston",
      "links": [
        {
          "href": "https://my.datacentred.io/api/users/293c38b7ec52c355414c6e975cde882f",
          "rel": "self"
        },
        {
          "href": "https://my.datacentred.io/api/schemas/user",
          "rel": "schema"
        }
      ],
      "updated_at": "2017-02-01T16:20:00Z"
    },
    {
      "created_at": "2017-02-01T16:20:00Z",
      "email": "elizabeth@ironmaiden.com",
      "first_name": "Elizabeth",
      "id": "fdd7020adf1ddff29b0f6b41a5a8a919",
      "last_name": "Princess",
      "links": [
        {
          "href": "https://my.datacentred.io/api/users/fdd7020adf1ddff29b0f6b41a5a8a919",
          "rel": "self"
        },
        {
          "href": "https://my.datacentred.io/api/schemas/user",
          "rel": "schema"
        }
      ],
      "updated_at": "2017-02-01T16:20:00Z"
    }
  ]
}
```


* Update a user

```ruby
Datacentred::User.update(user_id, params)
```

  Example

```ruby
Datacentred::User.update("6d5277716c4b10d2177814af50b77175", {"user": {"first_name": "Grim"}})
```

Will return updated user:

```json
{
 "user": {
   "created_at": "2017-02-01T16:20:00Z",
   "email": "death@afterlife.com",
   "first_name": "Grim",
   "id": "6d5277716c4b10d2177814af50b77175",
   "last_name": null,
   "links": [
     {
       "href": "https://my.datacentred.io/api/users/6d5277716c4b10d2177814af50b77175",
       "rel": "self"
     },
     {
       "href": "https://my.datacentred.io/api/schemas/user",
       "rel": "schema"
     }
   ],
   "updated_at": "2017-02-01T16:20:00Z"
 }
}
```

### Usage

* Get usage data

```ruby
Datacentred::Usage.show(year, month)
```

  Example

```ruby
Datacentred::Usage.show(2017, 6)
```

Will return usage for given year and month

```json
{
  "last_updated_at": "2017-07-12T10:46:54Z",
  "links": [
    {
      "href": "https://my.datacentred.io/api/usage/2017/6",
      "rel": "self"
    },
    {
      "href": "https://my.datacentred.io/api/schemas/usage",
      "rel": "schema"
    }
  ],
  "projects": [...]
}
```

## Further Reading

Please check out the [DataCentred API Documentation](https://my.datacentred.io/api/docs/v1) for a comprehensive explanation of the API and its capabilities.
