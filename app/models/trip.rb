class Trip < ActiveRecord::Base
  belongs_to :user
  has_many :pins
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 100 }
end