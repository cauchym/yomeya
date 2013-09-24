class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :name
      t.integer :book_id
      t.float :latitude
      t.float :longitude
      t.time :open_time
      t.time :close_time
      t.string :address
      t.string :memo

      t.timestamps
    end
  end
end
