class ApplicationController < ActionController::API
rescue_from ActiveRecord::RecordNotFound, with: :not_found

    def check_authentication
        # render json: { token: "not found" } if request.headers['Authorization'].nil?

        token = request.headers['Authorization'].gsub('Token ', '')
        
        if @current_user = User.find_by_token(token)
            if @current_user.token_expired?
                render json: { token: "expired" }
            end
        else
           render json: { user: "not found" }
        end
    end

    def current_user
        @current_user
    end

    def not_found
        render json: { user: 'Not found' }, status: :not_found
    end
#   def unauthorized
#     render json: { user: "unauthorized" }, status: 422
#   end

    
end
