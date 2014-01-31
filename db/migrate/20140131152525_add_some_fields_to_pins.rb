class AddSomeFieldsToPins < ActiveRecord::Migration
  def change
    add_column :pins, :day, :integer
  end
end
