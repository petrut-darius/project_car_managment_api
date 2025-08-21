class CarSerializer < ActiveModel::Serializer
  attributes :name, :user, :image


  def user
    object.user.username
  end
end
