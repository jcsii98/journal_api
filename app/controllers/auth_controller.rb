class AuthController < ApplicationController
    before_action :check_auth, only: [:current, :signout]

    def signup
        @user = User.new(signup_params)

        if @user.verify_password
            
            if @user.save
                render json: { token: @user.token, user: @user}
            else 
                render json: @user.errors, status: 422
            end
        else
            render json: { error: "Confirm password invalid" }, status: 422
        end
    end

    def signin
        @user_token = User.get_authentication_token(signin_params)

        if @user_token
            @user = User.find_by_authentication_token(@user_token)
            render json: { token: @user_token, user: @user }
        else
            render json: { message: "Invalid email or password" }, status: :unauthorized
        end
    end


    def current
        render json: @current_user, except: [:password_digest, :token]
    end


    # def reset_password_request
    #     user = User.find_by_email(params[:email])

    #     if user.nil?
    #         render json: { error: "not found" }, status: 404
    #     else
    #         user.generate_reset_password_token!

    #         render json: { token: user.reset_password_token }, status: 200
    #     end
    # end

    # def reset_password
    #     user = User.find_by_reset_password_token(params[:password_token])

    #     if user.nil?

    #     else 
    #         if user.verify_password(params[:password], params[:password_confirmation])
    #             if user.save
    #                 render json: { success: true }
    #             else
    #                 render json: { errors: user.errors }
    #             end
    #         else
    #             render json: { error: "passwords don't match" }
    #         end
    #     end
    # end


    private

    def signup_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def signin_params 
        params.require(:user).permit(:email, :password)
    end

    def check_auth
        token = headers['Authorization'].gsub('Token ')
        if @user = User.find_by_token(token)
               @user unless @user.token_expired?
        else
                render json: "no"
        end
    end


end