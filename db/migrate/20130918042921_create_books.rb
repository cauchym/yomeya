class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :image
      t.string :author
      t.string :isbn
      t.integer :value
      t.integer :wishlist_id
      t.text :shop_id

      t.timestamps
    end
  end
end
