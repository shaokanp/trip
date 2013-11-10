class AddOrderToPins < ActiveRecord::Migration
  def change
    add_column :pins, :order, :integer
  end
end
