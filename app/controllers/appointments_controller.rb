class AppointmentsController < ApplicationController
  before_action :require_authentication
  before_action :set_user!
  before_action :set_appointment!, only: %i[destroy]

  def index
    @appointments = Appointment.where(user_id: @user).order(created_at: :desc) 
    @appointment = @user.appointments.build
  end

  def create
    @appointments = Appointment.where(user_id: @user).order(created_at: :desc) 
    @appointment = @user.appointments.build appointment_params
    if @appointment.save
      flash[:success] = 'Appointment created!'
      redirect_to user_appointments_path
    else
      render :index
    end
  end

  def destroy
    @appointment.destroy
    flash[:success] = 'Appointment deleted!'
    redirect_to user_appointments_path(@user)
  end

  private

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
