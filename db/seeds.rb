User.create!(name: "Admin",
  email: "admin@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  is_admin: true)

Category.create! name:"Rails"

  99.times do |n|
  name  = Faker::Name.name
  Category.create! name: name
end
