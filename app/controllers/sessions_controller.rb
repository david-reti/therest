class SessionsController < ApplicationController
    def create
        redirect_to desired_path if session[:user_id] # redirect to home page if already signed in
        if @user = User.find_by!(email: session_params[:email]).authenticate(session_params[:password])
            session[:user_id] = @user.id # set the current user ID to the new user ID
            redirect_to desired_path, notice: t('permissions.signin_success')
        else
            redirect_to signin_path, status: :unauthorized, alert: t('permissions.wrong_password')
        end
    end

    def destroy
        reset_session
        redirect_to root_path, notice: t('permissions.signout_success')
    end

    private

    def session_params
        params.permit(:email, :password, :desired_path)
    end
end
