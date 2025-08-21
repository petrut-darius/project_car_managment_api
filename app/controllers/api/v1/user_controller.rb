class Api::V1::UserController < ApplicationController
  def index
    users = User.all

    render json: users, each_searializer: UserSerializer
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :first_name, :last_name, :password)
  end
end
