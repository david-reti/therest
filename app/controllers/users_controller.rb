class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        @user.roles << Role.find_by(name: "Reader")
        if @user.save
            redirect_to :root, notice: t('permissions.account_created')
        else
            render :new, status: :unprocessable_entity, alert: t('errors.could_not_create_account')
        end 
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
