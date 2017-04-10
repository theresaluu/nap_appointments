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
    tour_time         {
      ["10:00 AM", "10:30 AM","11:30 AM", "12:00 PM", "12:30 PM", "1:00 PM", "1:30 PM",
       "2:00 PM", "2:30 PM", "3:00 PM", "3:30 PM", "4:00 PM"].sample
    }
    tour_date         {
      hawaii_time_string = (Date.current + (rand(2..14).days)).strftime("%m/%d/%Y") + " #{tour_time}" + " -10:00"
      random = DateTime.strptime( hawaii_time_string, "%m/%d/%Y %I:%M %p %:z")

      #if this is a weekend, this will randomly add 2-4 days to ensure weekday
      random_date = (random.wday == 0 || random.wday == 6) ?
        (random + 2.days) : random
    }
    party_size        { rand(1..20) }
    children_u12      { rand(0..4) }
  end
end
