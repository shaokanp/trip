require 'carrierwave/orm/activerecord'

class Note < ActiveRecord::Base
  belongs_to :pin
  has_many :note_images
  validates :pin_id, presence: true
  validates :content, presence: true
  #mount_uploader :image, NoteImageUploader
end
