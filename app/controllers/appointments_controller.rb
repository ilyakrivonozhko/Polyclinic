class AppointmentsController < ApplicationController
  before_action :require_authentication
  before_action :set_user!
  before_action :set_appointment!, only: %i[destroy]
  before_action :authorize_appointment!
  after_action :verify_authorized

  def index
    @appointments = Appointment.where(user_id: @user).order(created_at: :desc) .page params[:page]
    @appointment = @user.appointments.build
  end

  def create
    @appointment = @user.appointments.build appointment_params
    if @appointment.save
      flash[:success] = 'Appointment created!'
      redirect_to appointments_path
    else
      render :index
    end
  end

  def destroy
    @appointment.destroy
    flash[:success] = 'Appointment deleted!'
    redirect_to appointments_path
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

  def set_appointment!
    @appointment = @user.appointments.find params[:id]
  end

end
