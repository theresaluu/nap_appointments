FactoryGirl.define do
  factory :reservation do
    name              { Faker::GameOfThrones.character }
    phone             { Faker::PhoneNumber.cell_phone }
    email             { Faker::Internet.email }
    city              { Faker::Address.city }
    address1          { Faker::Address.street_address }
    address2          { Faker::Address.secondary_address }
    state             { Faker::Address.state_abbr }
    zip               { Faker::Address.zip_code }
    country           { Faker::Address.country }
    consent_to_email  { Faker::Boolean.boolean }
    message           { Faker::Hipster.sentences(2) }
    maui_stay         { ["Marriott", "Hilton", "AirBnB"].sample }
    admin_id          { rand(1..4) }
    tour_date         {
      random_date = DateTime.now.beginning_of_day + (rand(1..14).days)

      #if this is a weekend, this will randomly add 2-4 days to ensure weekday
      random_date = random_date.wday === (0 || 6) ?
        (random_date + rand(2..5).days) : random_date
    }
    tour_time         {
      ["10:00AM", "10:30AM","11:30AM", "12:00PM", "12:30PM", "1:00PM", "1:30PM",
       "2:00PM", "2:30PM", "3:00PM", "3:30PM", "4:00PM"].sample
    }
    party_size        { rand(1..20) }
    children_u12      { rand(0..4) }
  end
end
