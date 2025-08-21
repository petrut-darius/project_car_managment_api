class User < ApplicationRecord
  rolify
  has_secure_password
  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password_digest, presence: true
  has_many :cars
  has_many :car_tasks
  after_create :assign_default_role

  def assign_default_role
    self.add_role(:simple_user) if self.roles.blank?
  end
end
