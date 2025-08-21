class Car < ApplicationRecord
  # validates :name, presence: true, length: { maximum: 10 }
  has_many :car_tasks
  belongs_to :user
  has_one_attached :image
end
