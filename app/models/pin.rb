class Pin < ActiveRecord::Base
  belongs_to :trip
  validates :trip_id, presence: true
  validates :title, presence: true, length: { maximum: 100 }
  default_scope -> { order('start_time ASC') }
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
end
