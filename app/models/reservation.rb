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
    in: ["10:00 AM", "10:30 AM","11:30 AM", "12:00 PM", "12:30 PM", "1:00 PM",
         "1:30 PM", "2:00 PM", "2:30 PM", "3:00 PM", "3:30 PM", "4:00 PM"]
  }

  %i(name email phone tour_date tour_time party_size children_u12)
    .each do |a|
      validates a, presence: true
    end

  validate :tour_date_cannot_be_out_of_range
  validate :tour_date_cannot_be_today
  validate :tour_date_cannot_be_weekend

  store :time_and_date_data, accessors: [:utc_offset, :parsed_date_from_form]
  private

  def tour_date_cannot_be_out_of_range
    if tour_date.present? && (tour_date > DateTime.current.beginning_of_day + 62.days)
      errors.add(:tour_date, "tours cannot be booked this far in advance")
    end
  end

  #if we are indeed keeping tour_date as DateTime, we have to keep ensure that
  #tours can't be booked until the next day at opening hours
  def tour_date_cannot_be_today
    if tour_date.present? &&
      (tour_date < (DateTime.current.beginning_of_day + 1.day).change(hour: 0))

      errors.add(:tour_date, "tours cannot be booked for same day appointments")
    end
  end

  def tour_date_cannot_be_weekend
    if tour_date.present? && (tour_date.wday == 6  || tour_date.wday == 0)
      errors.add(:tour_date, "tours cannot be booked for the weekend")
    end
  end

  def self.tour_times
    [
      "10:00 AM",
      "10:30 AM",
      "11:30 AM",
      "12:00 PM",
      "12:30 PM",
      "1:00 PM",
      "1:30 PM",
      "2:00 PM",
      "2:30 PM",
      "3:00 PM",
      "3:30 PM",
      "4:00 PM"
    ]
  end

  def self.tour_numbers_children
    [
      [0],
      [1],
      [2],
      [3],
      [4]
    ]
  end

end
