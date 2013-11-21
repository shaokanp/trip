class AddEndTimeToPins < ActiveRecord::Migration
  def change
    add_column :pins, :end_time, :date
  end
end
