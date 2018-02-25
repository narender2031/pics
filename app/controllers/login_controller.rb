class LoginController < ApplicationController
    def index
        
    end

    def create
        if params[:email].blank?
            flash[:notice] = "email is missing."
            puts "MANU"
            redirect_to login_path
        elsif params[:password].blank?
            puts "ANKU"
            flash[:notice] = "password is missing."
            redirect_to login_path
        elsif params[:email].include?("@")
            puts "PASSS"
            puts params[:password]
            user = User.find_by(email: params[:email])
            if user && user.authenticate(params[:password])
                puts "Magic"
                session[:user_id] = user.id
                cookies[:token] = user.token
                redirect_to root_path
            else
                puts "Hello man"
                flash[:notice] = "Email or password is invalid"
                redirect_to login_path
            end
        else
            flash[:notice] = "email is incorrect please use an correct email."
            redirect_to login_path
        end
    end

    def logout
        session[:user_id] = nil
        cookies[:token] = nil
        redirect_to login_path
    end
end
