require_relative 'redis_connection'

module Grape
	module RedisSessions
		module Helpers
			module AuthenticationHelper
				def authenticate!
		      error!('401 Unauthorized', 401) unless current_user_id
		    end

				def create_session(user_id)
					cookies[:session_id] = SecureRandom.hex(24)
					redis_connection.store_session(cookies[:session_id], user_id)
				end

				def current_user_id
					redis_connection.user_id_from_session_id(cookies[:session_id])
				end

				def end_session
					redis_connection.delete_session(cookies[:session_id])
					cookies.delete :session_id
				end
			end
		end
	end
end
