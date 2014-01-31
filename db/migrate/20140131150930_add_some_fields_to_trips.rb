class AddSomeFieldsToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :description, :string
    add_column :trips, :start_date, :datetime
    add_column :trips, :days, :integer
    add_column :trips, :cover_image_url, :string
    add_column :trips, :is_public, :boolean
  end
end
