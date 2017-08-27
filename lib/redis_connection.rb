require 'redis'
require 'securerandom'

module Grape
  module RedisSessions
    class RedisConnection
      class << self
        def connect(configuration)
          unless @redis_sessions
            @redis_sessions = RedisSessions.new(configuration)
          end
          @redis_sessions
        end

        def reset
          @redis_sessions = nil
        end
      end
      
      def initialize(configuration)
        @redis = Redis.new(url: configuration.endpoint)
        @session_lifetime = configuration.session_lifetime.to_i
      end

      def store_session(session_id, user_id)
        @redis.set(session_id, user_id)
        @redis.expire(session_id, @session_lifetime)
      end

      def delete_session(session_id)
        @redis.del(session_id)
      end

      def user_id_from_session_id(session_id)
        @redis.get(session_id)
      end

      def sessions_server_alive?
        @redis.ping
      end
    end
  end
end