class CreatePins < ActiveRecord::Migration
  def change
    create_table :pins do |t|
      t.string :title
      t.integer :trip_id

      t.timestamps
    end
  end
end
