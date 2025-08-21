class CarTaskSerializer < ActiveModel::Serializer
  attributes :id, :content, :user, :car, :image

  def user
    object.car.user.username
  end

  def car
    object.car.name
  end
end
