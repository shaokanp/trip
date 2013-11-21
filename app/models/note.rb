class Note < ActiveRecord::Base
  belongs_to :pin
  validates :pin_id, presence: true
  validates :title, presence: true, length: { maximum: 100 }
end
