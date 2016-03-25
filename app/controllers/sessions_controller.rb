class SessionsController < ApplicationController

    def new
       if current_user
           redirect_to home_path(0)
       end
    end

    def create
        user = User.find_by_email(params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to home_path(0)
        else
            flash[:alert] = "Invalid Login"
            redirect_to login_path
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to login_path
    end
end
