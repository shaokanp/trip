namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example User",
                 email: "shaokanp@gmail.com",
                 password: "foobar",
                 password_confirmation: "foobar",
                 admin: true)
    99.times do |n|
      name  = Faker::Name.name
      email = "dummy-#{n+1}@mail.com"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    Trip.create!(title: 'a trip',
                 user_id: 1)
    3.times do |n|
      title = "Pin number #{n+1}"
      Pin.create!(title: title,
                  pin_type: 'attraction',
                  address: 'Taipei 101',
                  trip_id: 1,
                  order: n)
    end
  end
end