json.array!(@books) do |book|
  json.extract! book, :title, :image, :author, :isbn, :value, :wishlist_id, :shop_id
  json.url book_url(book, format: :json)
end
