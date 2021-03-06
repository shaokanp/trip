require 'faker'

FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :trip do
    title 'A nice trip.'
    user
  end

  factory :pin do
    title 'A pin.'
    start_time Time.zone.parse('2013-07-11 21:00')
    trip

    factory :invalid_pin do
      title ''
    end

  end

  factory :note do
    content 'A note'
    image ''
    pin
  end

end