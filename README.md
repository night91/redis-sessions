# Grape::RedisSessions

Simple gem to provide session based on access token for Grape using a Redis server as datastore.
The token is sent in the headers as Authentication: access_token. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'redis-sessions'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install redis-sessions

## Usage

### Basic Usage

```ruby
require 'grape'
require 'redis-sessions'

class API < Grape::API
  Grape::RedisSessions.configure do |config|
  	config.redis_endpoint = 'The Redis server endpoint will go here (redis://localhost:6379/test)'
  	config.access_token_lifetime = 'Token lifetime in seconds (3600)'
  end
  
  helpers Grape::RedisSessions::Helpers::Authentication
end
```

### Grape::RedisSessions::Helpers::Authentication
```ruby
module Grape
  module RedisSessions
    # Helpers
    module Helpers
      # Authentication helper
      module Authentication
        # Check if exists session active with the access token provided
        def authenticate!
          error!('401 Unauthorized', 401) unless current_user_id
        end

        # Check the user is autehnticated or not
        def is_authenticated?
          !current_user_id.nil?
        end

        # Create an access token binded to a user_id
        def create_session(user_id)
          access_token_id = generate_random_access_token
          RedisSessions.redis_connection.store_access_token(access_token_id, user_id)
          access_token_id
        end

        # Retrieve the user_id binded to the access token provided
        def current_user_id
          check_access_token
          RedisSessions.redis_connection.user_id_from_access_token_id(headers['Authorization'])
        end

        # Finish the session for the access token provided
        def end_session
          check_access_token
          RedisSessions.redis_connection.delete_access_token(headers['Authorization'])
        end

        # Check if the access token exists in the headers of the request
        def check_access_token
          unless headers['Authorization']
            error!('Authorization header not found', 400)
          end
        end

        # Generate a random length 44 chars access token
        def generate_random_access_token
          SecureRandom.hex(24)
        end
      end
    end
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/night91/redis-sessions. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Grape::RedisSessions project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/night91/redis-sessions/blob/master/CODE_OF_CONDUCT.md).
