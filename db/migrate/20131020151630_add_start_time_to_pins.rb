class AddStartTimeToPins < ActiveRecord::Migration
  def change
    add_column :pins, :start_time, :datetime
  end
end
