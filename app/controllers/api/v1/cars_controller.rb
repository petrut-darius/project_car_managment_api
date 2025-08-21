class Api::V1::CarsController < ApplicationController
  before_action :authenticate
  def index
    if @user.has_role? :admin
      cars = Car.limit(limit).offset(params[:offset])
    else
      cars = @user.cars.limit(params[:limit]).offset(params[:offset])
    end
      render json: cars, each_serializer: CarSerializer
  end

  def show
    if @user.has_role? :admin
      car = Car.find(params[:id])
    else
      car = @user.cars.find(params[:id])
    end

    if !car.nil?
      render json: car
    else
      render json: car.errors, status: :unprocessable_entity
    end
  end
  def create
    car = @user.cars.build(car_params)

    if car.save
      CarAndTasksMailer.with(user: @user).created_car.deliver_later(wait: 10.seconds)
      render json: car, status: :created
    else
      render json: car.errors, status: :unprocessable_entity
    end
  end

  def destroy
    car = set_car

    car.destroy!

    head :no_content
  end


  private

  # def requie_admin
  # if current_user&.admin?
  #  render json: { error: "Nu ai voie sa faci aceasta actiune" }
  # end
  # end

  def limit
    # :limit -> ce da useru; 100 -> default
    [ params.fetch(:limit, ApplicationController::LIMIT).to_i, ApplicationController::LIMIT ].min
  end

  def set_car
    Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:name, :image)
  end
end
