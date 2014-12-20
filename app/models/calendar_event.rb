class CalendarEvent < ActiveRecord::Base

  acts_as_paranoid

  validates :starts_at, presence: true, date: true
  validates :ends_at, presence: true, date: {after: :starts_at}
  validates :user, presence: true

  belongs_to :user

  after_validation :add_datetime_errors

  def starts_at_date
    starts_at.to_date if starts_at.present?
  end

  def starts_at_date=(starts_at_date)
    starts_at_date = Date.parse(starts_at_date) if starts_at_date.is_a? String
    self.starts_at = Time.now.beginning_of_day if !starts_at.present?
    self.starts_at = starts_at.change_date(starts_at_date)
  end

  def starts_at_time
    starts_at.to_time if starts_at.present?
  end

  def starts_at_time=(starts_at_time)
    starts_at_time = Time.parse(starts_at_time) if starts_at_time.is_a? String
    self.starts_at = Time.now.beginning_of_day if !starts_at.present?
    self.starts_at = starts_at.change_time(starts_at_time)
  end

  def ends_at_date
    ends_at.to_date if ends_at.present?
  end

  def ends_at_date=(ends_at_date)
    ends_at_date = Date.parse(ends_at_date) if ends_at_date.is_a? String
    self.ends_at = Time.now.beginning_of_day if !ends_at.present?
    self.ends_at = ends_at.change_date(ends_at_date)
  end

  def ends_at_time
    ends_at.to_time if ends_at.present?
  end

  def ends_at_time=(ends_at_time)
    ends_at_time = Time.parse(ends_at_time) if ends_at_time.is_a? String
    self.ends_at = Time.now.beginning_of_day if !ends_at.present?
    self.ends_at = ends_at.change_time(ends_at_time)
  end

  def add_datetime_errors
    errors[:starts_at].each do |msg|
      errors.add(:starts_at_date, msg)
      errors.add(:starts_at_time, msg)
    end

    errors[:ends_at].each do |msg|
      errors.add(:ends_at_date, msg)
      errors.add(:ends_at_time, msg)
    end
  end

end
