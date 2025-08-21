class ApplicationController < ActionController::API
  # baga un block rescue in in orice metoda din orice controller si ca text in blocku rescue baga ce ai bagat la with:
  rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed
  before_action :authenticate
  rescue_from JWT::VerificationError, with: :invalid_token
  rescue_from JWT::DecodeError, with: :decode_error
  LIMIT = 100
  private

  def authenticate
    authorization_header = request.headers["Authorization"]
    token = authorization_header.split(" ").last if authorization_header
    decoded_token = JsonWebToken.decode(token)

    @user = User.find(decoded_token[:user_id])
  end

  def invalid_token
    render json: { invalid_token: "invalid token" }
  end

  def decode_error
    render json: { decode_error: "decode error" }
  end

  def not_destroyed(e)
    render json: { errors: e.record.errors }, status: :unprocessable_entity
  end
end
