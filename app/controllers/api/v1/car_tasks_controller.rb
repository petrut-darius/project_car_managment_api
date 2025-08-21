class Api::V1::CarTasksController < ApplicationController
  before_action :authenticate

  def index
    if @user.has_role? :admin
      car_tasks = CarTask.limit(limit).offset(params[:offset])
    else
      car = find_car
      car_tasks = car.car_tasks.limit(params[:limit]).offset(params[:offset])
    end
      render json: car_tasks, each_searializer: CarTaskSerializer
  end
  def create
    if @user.has_role? :admin
      car = Car.find(params[:car_id])
    else
      car = find_car
    end
    car_task = car.car_tasks.build(car_task_params)
    car_task.user = car.user
    if car_task.save
      # .with(user: @user) -> creaza un hash -> { user: @user} si il trimite ca parametru catre mailer
      CarAndTasksMailer.with(user: @user, car: car).created_car_task.deliver_later(wait: 10.seconds)
      CarAndTasksMailer.with(user: @user, car: car, task: car_task).one_week_get_done_car_task.deliver_later(wait_until:  car_task.get_done_till - 1.week)
      render json: car_task, status: :created
    else
      render json: car_task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    car = find_car
    car_task = car.car_tasks.find(params[:id])
    car_task.destroy!
    head :no_content
  end

  private

  def limit
    [ params.fetch(:limit, ApplicationController::LIMIT).to_i, ApplicationController::LIMIT ].min
  end

  def find_car
    @user.cars.find(params[:car_id])
  end

  def car_task_params
    params.require(:car_task).permit(:content, :get_done_till, :image)
  end
end
