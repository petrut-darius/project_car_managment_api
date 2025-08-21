class CarAndTasksMailer < ApplicationMailer
  default from: "notifications@example.com"

  def created_car
    @user = params[:user]
    @pdi_ig  = "https://www.instagram.com/petrut_.darius/"
    mail(to: @user.email, subject: "Welcome to My Awesome Site")
  end

  def created_car_task
    @user = params[:user]
    @car = params[:car]
    @pdi_ig  = "https://www.instagram.com/petrut_.darius/"
    mail(to: @user.email, subject: "Welcome to My Awesome Site")
  end

  def one_week_get_done_car_task
    @user = params[:user]
    @car = params[:car]
    @task = params[:task]
    @pdi_ig  = "https://www.instagram.com/petrut_.darius/"
    mail(to: @user.email, subject: "Welcome to My Awesome Site")
  end
end
