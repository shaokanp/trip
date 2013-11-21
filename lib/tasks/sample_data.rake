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

    Pin.create!(title: 'Statue of Liberty',
                pin_type: 'attraction',
                address: 'Statue of Liberty',
                trip_id: 1)

    Pin.create!(title: 'MOMA',
                pin_type: 'attraction',
                address: 'Museum of Modern Art',
                trip_id: 1)

    Pin.create!(title: 'Empire State Building',
                pin_type: 'attraction',
                address: 'Empire State Building',
                trip_id: 1)
  end
end