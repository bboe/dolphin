# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

exit 0 if User.count.positive? || Rails.env.production?

1.upto(16) do |i|
  User.create!(name: "User#{i}", email: "#{i}@test", image_url: 'http://localhost/',
               provider: 'Test', uid: i)
end

users = Array.new(User.all)

64.times do
  to = users.sample
  from = nil
  from = users.sample until from.present? && from != to
  dolphin = Dolphin.new(from: from, to: to, source: 'Test')
  dolphin.save!(validate: false)
end
