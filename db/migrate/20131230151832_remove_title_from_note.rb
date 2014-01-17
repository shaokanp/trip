class RemoveTitleFromNote < ActiveRecord::Migration
  def change
    remove_column :notes, :title, :string
  end
end
