class CarTask < ApplicationRecord
  belongs_to :car
  belongs_to :user
  validates :get_done_till, presence: true
  validates :content, presence: true, length: { in: 5..50 }
  has_one_attached :image
end
