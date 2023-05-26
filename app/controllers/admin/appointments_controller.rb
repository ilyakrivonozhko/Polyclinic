module Admin
  class AppointmentsController < BaseController
    before_action :require_authentication
    before_action :set_user!
    before_action :authorize_appointment!
    after_action :verify_authorized

    def index
      @my_appointments = Appointment.where(user_id: @user).order(created_at: :desc).page params[:page]
      @appointments = Appointment.order(created_at: :desc).page params[:page]
      @windows = Window.where(user_id: @user).order(created_at: :desc) 
      @appointments_to_me = Appointment.where(window_id: @windows).order(created_at: :desc).page params[:page]
      @appointment = @user.appointments.build
    end

    def create
      @user = User.find appointment_params[:user_id]
      @appointment = @user.appointments.build appointment_params
      if @appointment.save
        flash[:success] = 'Appointment created!'
        redirect_to admin_appointments_path
      else
        render :index
      end
    end

    def destroy
      @appointment = Appointment.find params[:id]
      @appointment.destroy
      flash[:success] = 'Appointment deleted!'
      redirect_to admin_appointments_path
    end

    private

    def authorize_appointment!
      authorize(@appointment || Appointment)
    end

    def appointment_params
      params.require(:appointment).permit(:window_id, :user_id)
    end

    def set_user!
      @user = current_user
    end
  end
end