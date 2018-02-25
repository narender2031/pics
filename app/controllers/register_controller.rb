class RegisterController < ApplicationController
    def index
        @user = User.new
    end
    def create
      @user_email =  User.find_by(email: user_params[:email])
      @user_name = User.find_by(user_name: user_params[:user_name])
      @user_phone = User.find_by(phone: user_params[:phone])
      if @user_email
        flash[:notice] = "This email is taken by another user"
        redirect_to register_path
      elsif @user_name
        flash[:notice] = "User name is taken by another user"
        redirect_to register_path
      elsif @user_phone 
        flash.notice = "Phone number is taken by another user"
        redirect_to register_path
      elsif 
        @user = User.new
        @user.first_name = user_params[:first_name]
        @user.last_name = user_params[:last_name]
        @user.phone = user_params[:phone]
        @user.email = user_params[:email]
        @user.password = user_params[:password]
        @user.user_name = user_params[:user_name]
        if @user.save
            session[:user_id] = @user.id
            cookies[:token] = @user.token
            # puts "Hello"
            redirect_to root_path
        else
            flash[:notice] = "email and password are incorrect"
            redirect_to register_path
        end
      end
    
    end

    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :phone, :user_name)
    end
end
