class UserSerializer < ActiveModel::Serializer
  attributes :full_name, :email, :username, :cars

  def full_name
    "#{object.first_name} #{object.last_name}"
  end
end
