require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let(:reservation) { FactoryGirl.build(:reservation) }

  let(:res_90days) {
    FactoryGirl.build(:reservation, tour_date: (DateTime.current + 90.days))
  }

  let(:res_today) {
    FactoryGirl.build(:reservation, tour_date: (DateTime.current.noon))
  }

  let(:mtn_res) {
    Time.zone = "Mountain Time (US & Canada)"
    new_created_time = Time.zone.parse("2017-01-26 07:48:27")
    new_res_time = Time.zone.parse("2017-01-28 00:00:00") - 6.hours
    Timecop.freeze new_created_time
    FactoryGirl.build(:reservation,
                      tour_date: new_res_time)
  }

  let(:after_hours) {
    FactoryGirl.build(:reservation, tour_time: "5:00 PM")
  }

  let(:early_hours) {
    FactoryGirl.build(:reservation, tour_time: "6:00 AM")
  }

  let(:biz_hours) {
    FactoryGirl.build(
      :reservation, tour_time: "1:00 PM", tour_date: (
        if !DateTime.current.saturday? && !DateTime.current.friday?
          (DateTime.current + 1.day)
        else
          (DateTime.current + 3.day)
        end
      )
    )
  }

  let(:res_sat) {
    additional_days = 6 - DateTime.current.beginning_of_day.wday
    FactoryGirl.build(
      :reservation,
      tour_date: (DateTime.current.beginning_of_day + additional_days.days)
    )
  }

  let(:res_sun) {
    additional_days = 7 - DateTime.current.beginning_of_day.wday
    FactoryGirl.build(
      :reservation,
      tour_date: (DateTime.current.beginning_of_day + additional_days.days)
    )
  }

  %i(name email phone tour_date tour_time party_size children_u12).each do |a|
    it { should validate_presence_of(a) }
  end

  it "has at least on adult in each party" do
    should validate_numericality_of(:party_size)
      .only_integer
      .is_greater_than_or_equal_to(1)
  end

  it "ensures that children_u12 is an integer" do
    should validate_numericality_of(:children_u12)
      .only_integer
  end

  it "allows tour dates to happen the next day up to 60 days out" do
    expect(res_90days).not_to be_valid
    expect(res_today).not_to be_valid
  end

  it "does not allow bookings outside business hours" do
    expect(after_hours).not_to be_valid
    expect(early_hours).not_to be_valid
    expect(biz_hours).to be_valid
  end

  it "prevents users from booking saturday tours" do
    expect(res_sat).not_to be_valid
  end

  it "prevents users from booking sunday tours" do
    expect(res_sun).not_to be_valid
  end

  it "reservations are initially set to 'pending'" do
    expect(reservation.aasm_state).to eq("pending")
  end

  it "reservations on a mtn timezone" do
    expect(mtn_res).to be_valid
  end
  Timecop.return
end
