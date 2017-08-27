module Grape
  module RedisSessions
    # Configuration handler
    class Configuration
      # Default redis server endpoint
      DEFAULT_REDIS_ENDPOINT = 'redis://localhost/default'.freeze

      # Default access token lifetime in seconds
      DEFAULT_ACCESS_TOKEN_LIFETIME = 3600

      # Redis endpoint
      attr_accessor :redis_endpoint

      # Access token lifetime
      attr_accessor :access_token_lifetime

      def initialize
        reset!
      end

      # Reset configuration to default
      def reset!
        self.redis_endpoint = DEFAULT_REDIS_ENDPOINT
        self.access_token_lifetime = DEFAULT_ACCESS_TOKEN_LIFETIME
      end
    end
  end
end
