class CreateWishlists < ActiveRecord::Migration
  def change
    create_table :wishlists do |t|
      t.string :url
      t.string :name
      t.integer :scrape_status
      t.text :book_id
      t.text :shop_id
      t.boolean :notice
      t.integer :distance

      t.timestamps
    end
  end
end
