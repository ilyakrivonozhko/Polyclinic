module Admin
    class UsersController < BaseController
        before_action :require_authentication
        before_action :set_user!, only: %i[edit update destroy]
        before_action :authorize_user!
        after_action :verify_authorized

        def index
            respond_to do |format|
                format.html do
                    @users = User.order(created_at: :desc).page params[:page]
                end
                format.zip do
                    respond_with_zipped_users
                end
            end
        end

        def edit; end

        def update
          if @user.update user_params
            flash[:success] = 'User profile was successfully updated!'
            redirect_to admin_users_path
          else
            render :edit
          end
        end

        def destroy
            @user.destroy
            flash[:success] = "User has been deleted!"
            redirect_to admin_users_path
        end

        private

        def respond_with_zipped_users
            compressed_filestream = Zip::OutputStream.write_buffer do |zos|
                User.order(created_at: :desc).each do |user|
                    zos.put_next_entry "user_#{user.id}.xlsx"
                    zos.print render_to_string(
                    layout: false, handlers: [:axlsx], formats: [:xlsx], template: 'admin/users/user', locals: { user: user }
                    )
                end
            end
            compressed_filestream.rewind
            send_data compressed_filestream.read, filename: 'users.zip'
        end

        def set_user!
            @user = User.find params[:id]
        end

        def user_params
            params.require(:user).permit(:email, :phone_number, :name, :surname, :patronymic, :role, :password, :password_confirmation, :old_password).merge(admin_edit: true)
        end

        def authorize_user!
            authorize(@user || User)
        end
    end
end