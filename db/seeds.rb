5.times do
 User.create(name: Faker::Name.unique.name, email: Faker::Internet.email)
end

5.times do
 Group.create(name: Faker::Types.rb_string, description: Faker::Lorem.sentence)
end
