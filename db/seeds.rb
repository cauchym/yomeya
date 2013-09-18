# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# -*- coding: utf-8 -*-

users_name = ['社長', 'なっくる', 'kikunantoka', 'こし']
users = User.all
if users.blank?
  users_name.each do |name|
    User.create(:name => name)
  end
end
users = User.all

genres_name = ['不具合', '要望', '質問', 'その他']
genres = Genre.all
if genres.blank?
  genres_name.each do |name|
    Genre.create(:name => name)
  end
end

machines_name = ['SP', 'FP']
machines = Machine.all
if machines.blank?
  machines_name.each do |name|
    Machine.create(:name => name)
  end
end

# if Rails.env == 'development'
#   User.create(email: "staff@example.com", password: "password", password_confirmation: "password", name: "すたっふ", role: "admin")
#   puts %Q!
# 1 staff users have been created.
# You can now log in as 'staff@example.com' with passowrd 'password'
#   !
# end

