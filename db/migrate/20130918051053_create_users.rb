class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.text :wishlist_id
      t.text :ignore_shops
      t.text :ignore_books
      t.float :last_latitude
      t.float :last_longitude
      t.integer :role

      t.timestamps
    end
  end
end
