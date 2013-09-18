json.array!(@wishlists) do |wishlist|
  json.extract! wishlist, :url, :name, :book_id, :shop_id, :notice, :distance
  json.url wishlist_url(wishlist, format: :json)
end
