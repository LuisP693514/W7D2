class SessionsController < ApplicationController
skip_before_action :verify_authenticity_token 
    before_action :require_logged_in, only: [:destroy]
    before_action :require_logged_out, only: [:new, :create]

    def create
        @user = User.find_by_creds(params[:user][:email], params[:user][:password])

        if @user
            login(@user)
            redirect_to user_url(@user)
        else
            @user = User.new
            flash[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def new
    end

    def destroy
        logout! if logged_in?

        flash[:messages] = ["Successfully logged out!"]

        redirect_to new_session_url
    end
    
end
