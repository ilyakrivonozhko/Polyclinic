module Admin
  class WindowsController < BaseController
    before_action :require_authentication
    before_action :set_user!, only: %i[index]
    before_action :authorize_window!
    after_action :verify_authorized

    def index
      @windows = Window.order(created_at: :desc)
      @window = @user.windows.build
    end

    def create
      @user = User.find window_params[:user_id]
      @window = @user.windows.build window_params
      if @window.save
        flash[:success] = 'Window created!'
        redirect_to admin_windows_path
      else
        @windows = Window.order(created_at: :desc)
        render :index
      end
    end

    def destroy
      @window = Window.find params[:id]
      @window.destroy
      flash[:success] = 'Window deleted!'
      redirect_to admin_windows_path
    end

    private

    def set_user!
      @user = current_user
    end

    def window_params
      params.require(:window).permit(:datetime, :user_id)
    end

    def authorize_window!
      authorize(@window || Window)
    end
  end
end
