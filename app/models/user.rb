# require "base64"
# require "bcrypt"

class User < ApplicationRecord
    include BCrypt

    # has_secure_password
    
    after_create :generate_token

    def password
        @password ||= Password.new(password_digest)
    end


    def self.authenticate(signin_params)
        p signin_params
        current = User.find_by_email(signin_params[:email])

        if current.present?
            if current.password == signin_params[:password]
                current.generate_token 

                return current.token
            else 
                return "invalid"
            end
        else
            return "not found"
        end
    end


    def generate_token
        # if self.token && self.token_expiration < Time.now
            self.token = Base64.encode64(self.email + '_journal');
            self.token_expiration = Rails.application.config.auth_token_expiration
        # end

        self.save
    end

    def verify_password(password, password_confirmation)
        if password == password_confirmation
            self.password_digest = Bcrypt::Password.create(password)
        end
    end

    def token_expired?
        @user.token_expiration < Time.now
    end
    
end
