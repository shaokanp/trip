require 'carrierwave/orm/activerecord'

class Note < ActiveRecord::Base
  belongs_to :pin
  validates :pin_id, presence: true
  validates :content, presence: true
  mount_uploader :image, NoteImageUploader
end
