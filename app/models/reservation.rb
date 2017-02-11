class Reservation < ApplicationRecord
  include AASM

  aasm do
    state :pending, :initial => true
    state :confirmed
    state :rejected
    state :checkedin
    state :completed
    state :noshowed
    state :archived

    event :confirm do
      transitions :to => :confirmed
    end

    event :reject do
      transitions :to => :rejected
    end

    event :checkin do
      transitions :to => :checkedin
    end

    event :complete do
      transitions :to => :completed, :from => [:confirmed, :noshowed, :checkedin]
    end

    event :noshow do
      transitions :to => :noshowed, :from => [:confirmed]
    end

    event :archive do
      transitions :to => :archived, :from => [:noshowed, :completed]
    end

    event :reset do
      transitions :to => :pending
    end
  end

  validates :party_size,
    numericality: { only_integer: true , greater_than_or_equal_to: 1}
  validates :children_u12,
    numericality: { only_integer: true , greater_than_or_equal_to: 0}
  validates :tour_time, inclusion:{
    in: ["10:00AM", "10:30AM","11:30AM", "12:00PM", "12:30PM", "1:00PM",
         "1:30PM", "2:00PM", "2:30PM", "3:00PM", "3:30PM", "4:00PM"]
  }

  %i(name email phone tour_date tour_time party_size children_u12)
    .each do |a|
      validates a, presence: true
    end

  validate :tour_date_cannot_be_out_of_range
  validate :tour_date_cannot_be_today
  validate :tour_date_cannot_be_weekend

  private

  def tour_date_cannot_be_out_of_range
    if tour_date.present? && (tour_date > DateTime.now.beginning_of_day + 62.days)
      errors.add(:tour_date, "tours cannot be booked this far in advance")
    end
  end

  #if we are indeed keeping tour_date as DateTime, we have to keep ensure that
  #tours can't be booked until the next day at opening hours
  def tour_date_cannot_be_today
    if tour_date.present? &&
      (tour_date < (DateTime.current.beginning_of_day + 1.day).change(hour: 10))

      errors.add(:tour_date, "tours cannot be booked for same day appointments")
    end
  end

  def tour_date_cannot_be_weekend
    if tour_date.present? && (tour_date.wday === 6  || tour_date.wday ===0)
      errors.add(:tour_date, "tours cannot be booked for the weekend")
    end
  end
end
