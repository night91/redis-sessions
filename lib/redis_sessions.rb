require 'redis_sessions/version'

require_relative 'configuration'
require_relative 'redis_connection'
require_relative 'authentication_helper'

module Grape
  # Handle sessions with Redis store for Grape
  module RedisSessions
    class << self
      # Access the configuration
      def config
        @config ||= Grape::RedisSessions::Configuration.new
      end

      # Set up the configuration
      def configure
        yield config
      end

      # Retrieve rge connection with the Redis server
      def redis_connection
        @redis_connection ||= RedisConnection.connect(config)
      end
    end
  end
end
