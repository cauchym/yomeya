json.array!(@users) do |user|
  json.extract! user, :email, :password, :wishlist_id, :ignore_shops, :ignore_books, :last_latitude, :last_longitude, :role
  json.url user_url(user, format: :json)
end
