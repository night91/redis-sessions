require 'redis'
require 'securerandom'

module Grape
  module RedisSessions
    # Class to handler the connection with the redis server
    class RedisConnection
      AUTHDOMAIN = 'auth'.freeze

      class << self
        # Create a singleton object to handle the connection
        def connect(configuration)
          @redis_sessions ||= RedisConnection.new(configuration)
        end

        # Reset the singleton object
        def reset
          @redis_sessions = nil
        end
      end

      # Create a connection with the Redis Server
      def initialize(configuration)
        @redis = Redis.new(url: configuration.redis_endpoint)
        @access_token_lifetime = configuration.access_token_lifetime
      end

      # Store the access_token binded to an user_id
      def store_access_token(access_token_id, user_id)
        @redis.set(auth_domain_key(access_token_id), user_id)
        @redis.expire(auth_domain_key(access_token_id), @access_token_lifetime)
      end

      # Delete the access token
      def delete_access_token(access_token_id)
        @redis.del(auth_domain_key(access_token_id))
      end

      # Retrieve user_id that is binded to the access token
      def user_id_from_access_token_id(access_token_id)
        @redis.get(auth_domain_key(access_token_id))
      end

      private

      # Create a domain for the keys stored
      def auth_domain_key(key)
        [AUTHDOMAIN, key].join('.')
      end
    end
  end
end
