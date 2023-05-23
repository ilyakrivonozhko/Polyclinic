class UsersController < ApplicationController
    def new
        @user = User.new
    end
    
    def create
        @user = User.new user_params
        if @user.save
            flash[:success] = "Welcome to the app, #{@user.name} #{@user.patronymic}!"
            redirect_to root_path
        else
            render :new
        end
    end

    private

    def user_params
        params.require(:user).permit(:email, :phone_number, :name, :surname, :patronymic, :role, :password, :password_confirmation)
    end
end