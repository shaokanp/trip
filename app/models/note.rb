class Note < ActiveRecord::Base
  attr_accessible :content, :pin_id, :image
  belongs_to :pin
  validates :pin_id, presence: true
  validates :title, presence: true, length: { maximum: 100 }
  mount_uploader :image, NoteImageUploader
end
