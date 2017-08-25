require "simple-redis-sessions/version"

require 'redis'

module SimpleRedisSessions
  class RedisSessions
  # Settings
    # {
    #   endpoint: "redis://:p4ssw0rd@10.0.1.1:6380/15"
    #   sessions_life: 3600 (in seconds)
    # }
    #
    # "redis://:p4ssw0rd@10.0.1.1:6380/15"
    def self.connect(settings)
      unless @redis
        @redis = RedisSessions.new(settings)
      end
      @redis
    end

    def self.reset
      @redis = nil
    end

    def initialize(settings)
      @redis_sessions = Redis.new(url: settings[:endpoint])
      @session_life = settings[:session_life].to_i
    end

    def create_session(session_id, user_id)
      @redis_sessions.set(session_id, user_id)
      @redis_sessions.expire(session_id, @session_life)
    end

    def destroy_session(session_id)
      @redis_sessions.del(session_id)
    end

    def user_id_from_session_id(session_id)
      @redis_sessions.get(session_id)
    end

    def sessions_server_alive?
      @redis_sessions.ping
    end

    def session_ttl(session_id)
      @redis_sessions.ttl(session_id)
    end
  end
end
