FactoryGirl.define do
  factory :user do
    name  'Marcus'
    email 'marcus@gmail.com'
    password 'foobar'
    password_confirmation 'foobar'
  end
end