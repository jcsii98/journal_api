class ApplicationController < ActionController::API
    before_action :check_auth

    def check_auth
        token = headers ['Authorization'].gsub('Token ')

        if @user = User.find_by_token(token)
            @user unless @user.token_expired?
        else
            render json: "no"
        end
    end

    
end
