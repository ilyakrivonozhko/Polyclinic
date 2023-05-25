class WindowsController < ApplicationController
  before_action :require_authentication
  before_action :set_user!
  before_action :set_window!, only: %i[destroy]

  def index
    @windows = Window.where(user_id: @user).order(created_at: :desc) 
    @window = @user.windows.build
  end

  def create
    @window = @user.windows.build window_params
    if @window.save
      flash[:success] = 'Window created!'
      redirect_to user_windows_path
    else
      render :index
    end
  end

  def destroy
    @window.destroy
    flash[:success] = 'Window deleted!'
    redirect_to user_windows_path(@user)
  end

  private

  def window_params
    params.require(:window).permit(:datetime, :user_id)
  end

  def set_user!
    @user = current_user
  end

  def set_window!
    @window = @user.windows.find params[:id]
  end

end
