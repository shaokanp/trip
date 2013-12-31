class AddImageToNote < ActiveRecord::Migration
  def change
    add_column :notes, :image, :string
  end
end
