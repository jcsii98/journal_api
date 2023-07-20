require "securerandom"
require "bcrypt"

class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  attr_accessor :password, :password_confirmation
  include BCrypt

  validates :name, presence: true
  
  has_many :categories

  attribute :token_expiration, :datetime

  before_create :verify_password
  after_create :generate_token

  def password
    @password ||= Password.new(password_digest)
  end

  def self.find_by_authentication_token(token)
    find_by(token: token)
  end
  
  def self.get_authentication_token(signin_params)
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
    self.token = SecureRandom.base64[0..32]
    self.token_expiration = DateTime.now + Rails.application.config.auth_token_expiration
    save
  end

  def verify_password
    if password == password_confirmation
      self.password_digest = BCrypt::Password.create(password)
    else
      errors.add(:password, "doesn't match")
      false
    end
  end

  def token_expired?
    token_expiration < Time.now
  end
end
