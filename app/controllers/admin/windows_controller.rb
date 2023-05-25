module Admin
  class WindowsController < ApplicationController
    before_action :require_authentication

    def index
      @user = current_user
      @windows = Window.order(created_at: :desc)
      @window = @user.windows.build
    end

    def create
      @user = User.find window_params[:user_id]
      @window = @user.windows.build window_params
      if @window.save
        flash[:success] = 'Window created!'
        redirect_to admin_user_windows_path
      else
        @windows = Window.order(created_at: :desc)
        render :index
      end
    end

    def destroy
      @user = User.find params[:user_id]
      @window = @user.windows.find params[:id]
      @window.destroy
      flash[:success] = 'Window deleted!'
      redirect_to admin_user_windows_path
    end

    private

    def window_params
      params.require(:window).permit(:datetime, :user_id)
    end
  end
end
