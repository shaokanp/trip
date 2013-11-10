class AddPinTypeToPins < ActiveRecord::Migration
  def change
    add_column :pins, :pin_type, :string
  end
end
