class Reservation < ApplicationRecord
  validates :party_size,
    numericality: { only_integer: true , greater_than_or_equal_to: 1}
  validates :children_u12,
    numericality: { only_integer: true , greater_than_or_equal_to: 0}

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
    if tour_date.present? && (tour_date < (DateTime.now + 1.day).change(hour: 10))
      errors.add(:tour_date, "tours cannot be booked for same day appointments")
    end
  end

  def tour_date_cannot_be_weekend
    if tour_date.present? && (tour_date.wday === 6  || tour_date.wday ===0)
      errors.add(:tour_date, "tours cannot be booked for the weekend")
    end
  end
end
