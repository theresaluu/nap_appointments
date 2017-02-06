require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let(:reservation) {FactoryGirl.create(:reservation)}
  it "has a valid factory" do
    expect(reservation).to be_valid
  end
end
