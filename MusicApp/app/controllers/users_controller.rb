class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token 

    def new
        @user = User.new
    end

    def show
        @user = User.find_by(id: params[:id])
    end 

    def create
        @user = User.new(user_params)

        if @user.save
            # login(@user)
            redirect_to user_url(@user)
        else
            flash[:errors] = @user.errors.full_messages
            render :new
        end

    end

    def edit
    end

    def destroy
    end

    def index
        @users = User.all
        # render :index
    end

    private

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

end
