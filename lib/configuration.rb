module Grape
  module SessionsRedis
    class Configuration
      attr_accessor :endpoint, :session_lifetime
    end
  end
end