class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?
    def current_user
        # Memoization of the current_user. If current_user is defined, give back, don't query db.
        # If not -> query db (find user)
        @current_user ||= User.find(session[:user_id]) if session[:user_id]            
    end

    def logged_in?
        # convert returned data from current_user into boolean:
        !!current_user 
    end
end
