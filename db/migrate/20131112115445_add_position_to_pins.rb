class AddPositionToPins < ActiveRecord::Migration
  def change
    add_column :pins, :position, :integer
  end
end
