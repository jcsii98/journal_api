class UsersController < ApplicationController
    before_action :check_authentication
    before_action :set_user
    
    def show
        render json: @user
    end


    def destroy
        @user.destroy
    end

    private 
    def set_user
        @user = @current_user
    end
    

end
