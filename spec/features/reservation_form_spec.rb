require 'rails_helper'

RSpec.describe "the reservation process" do
  it "makes a reservation" do
    visit '/'
    fill_in 'reservation[name]', with: 'President Barack Obama'
    fill_in 'reservation[phone]', with: '(999) 999-9999'
    fill_in 'reservation[email]', with: 'bo@potus.com'
    fill_in 'reservation[city]', with: 'Denver'
    select 'CO', :from => 'reservation[state]'
    fill_in 'reservation[zip]', with: '99999'
    select 'UNITED STATES', :from => 'reservation[country]'
    fill_in 'parsed_date_from_form', with: '03/30/2017'
    select '1:00 PM', :from => 'reservation[tour_time]'
    fill_in 'reservation[party_size]', with: '2'
    select '0', :from => 'reservation[children_u12]'
    fill_in 'reservation[maui_stay]', with: 'AirBnB'
    click_button 'Save Reservation'
    expect(page).to have_content 'President Barack Obama'
  end
end
