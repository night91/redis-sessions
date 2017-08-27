require_relative 'redis_connection'

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
          error!('Authorization header not found', 400) unless headers['Authorization']
        end

        # Generate a random length 44 chars access token
        def generate_random_access_token
          SecureRandom.hex(24)
        end
      end
    end
  end
end
