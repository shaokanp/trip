class Pin < ActiveRecord::Base
  PIN_TYPE = [PIN_ATTRACTION = 'attraction', PIN_MEETING = 'meeting', PIN_ACCOMMODATION = 'accommodation', PIN_DINING = 'dining', PIN_TRANSPORT = 'transport' ,PIN_UNDEFINED = 'undefined']
  belongs_to :trip
  has_many :notes
  validates :trip_id, presence: true
  validates :title, presence: true, length: { maximum: 100 }
  validates :pin_type, inclusion: {in: PIN_TYPE}
  geocoded_by :address
  acts_as_list scope: :trip
  after_validation :geocode, :if => :address_changed?

  before_save :default_values
  def default_values
    self.pin_type ||= Pin::PIN_ATTRACTION
  end
end
