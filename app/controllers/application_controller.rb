class ApplicationController < ActionController::Base
    include SortableColumns
    skip_before_action :verify_authenticity_token
    before_action :current_user

    # log in user
    def log_in(user)
        session[:user_id] = user.id
    end

    # check current user status 
    def current_user
        if session[:user_id]
            @current_user ||= User.find_by(id: session[:user_id])
        end
    end

    # check if logged in
    def logged_in?
        if current_user.nil?
            flash[:danger] = 'Please login first'
            redirect_to :root
        end
    end

    # check if admin
    def admin?
        if !session[:admin]
            flash[:danger] = 'Admin only page'
            redirect_to :root
        end
    end

    # log out user
    def log_out
        if session[:user_id]
            flash[:success] = 'You have been logged out'
        end
        session.delete(:user_id)
        session.delete(:admin)
        @current_user = nil
    end
end
