class WindowsController < ApplicationController
  before_action :require_authentication
  before_action :set_user!
  before_action :set_winwow!, only: %i[destroy]
  before_action :authorize_window!
  after_action :verify_authorized

  def index
    @windows = Window.where(user_id: @user).order(created_at: :desc).page params[:page]
    @window = @user.windows.build
  end

  def create
    @window = @user.windows.build window_params
    if @window.save
      flash[:success] = 'Window created!'
      redirect_to windows_path
    else
      render :index
    end
  end

  def destroy
    @window.destroy
    flash[:success] = 'Window deleted!'
    redirect_to windows_path
  end

  private

  def window_params
    params.require(:window).permit(:datetime, :user_id)
  end

  def set_user!
    @user = current_user
  end

  def set_winwow!
    @window = @user.windows.find params[:id]
  end

  def authorize_window!
    authorize(@window || Window)
  end
end
