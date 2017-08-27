require 'redis-sessions/version'

require_relative 'configuration'
require_relative 'redis_connection'
require_relative 'auth_helper'

module Grape
  module RedisSessions
  	class << self
      def config
        @config ||= Grape::RedisSessions::Configuration.new
      end

      def configure
        yield config
      end

      def redis_connection
        @redis_connection ||= RedisConnection.connect(config)
      end
    end
  end
end