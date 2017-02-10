require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let(:res_90days) {
    FactoryGirl.build(:reservation, tour_date: (DateTime.now + 90.days))
  }

  let(:res_today) {
    FactoryGirl.build(:reservation, tour_date: (DateTime.now.noon))
  }

  let(:res_tomorrow_in_biz_hr) {
    FactoryGirl.build(:reservation, tour_date: (DateTime.now + 1.day)
                      .change(hour: 11))
  }

  let(:res_sat) {
    additional_days = 6 - DateTime.now.beginning_of_day.wday
    FactoryGirl.build(
      :reservation,
      tour_date: (DateTime.now.beginning_of_day + additional_days.days)
    )
  }

  let(:res_sun) {
    additional_days = 7 - DateTime.now.beginning_of_day.wday
    FactoryGirl.build(
      :reservation,
      tour_date: (DateTime.now.beginning_of_day + additional_days.days)
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
    expect(res_tomorrow_in_biz_hr).to be_valid
  end

  it "prevents users from booking saturday tours" do
    expect(res_sat).not_to be_valid
  end

  it "prevents users from booking sunday tours" do
    expect(res_sun).not_to be_valid
  end

end
