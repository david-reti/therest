class ApplicationController < ActionController::Base
    helper_method :current_user, :signed_in?, :signin_required?

    def current_user
        @current_user ||= User.find_by id: session[:user_id]
    end

    def signed_in?
        current_user.present?
    end

    def redirect_to_signin
        if !signed_in? 
            redirect_to signin_path, notice: t('permissions.signin_required')
            return false
        end
        true
    end

    def signin_required?(params={})
        set_desired_path(params[:desired_path] || root_path)
        !redirect_to_signin
    end

    def set_desired_path(path)
        session[:desired_path] = path
    end

    def desired_path
        to_return = session.delete(:desired_path)
        to_return || root_path
    end
end
