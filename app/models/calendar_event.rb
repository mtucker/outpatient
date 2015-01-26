class CalendarEvent < ActiveRecord::Base
  acts_as_paranoid

  validates :starts_at, presence: true, date: true
  validates :ends_at, presence: true, date: { after: :starts_at }
  validates :user, presence: true

  belongs_to :user
  belongs_to :calendar_event_type

  scope :user, -> (user) { where('user_id = ?', "#{user.id}") }
  scope :starts_after, -> (start_dttm) { where('starts_at >= ?', "#{start_dttm}") if start_dttm.present? }
  scope :starts_before, -> (end_dttm) { where('starts_at <= ?', "#{end_dttm}") if end_dttm.present? }

  def title
    'Available'
  end

  def starts_at_date
    starts_at.to_date.in_time_zone if starts_at.present?
  end

  def starts_at_date=(starts_at_date)
    starts_at_date = Date.parse(starts_at_date) if starts_at_date.is_a? String
    self.starts_at = Time.zone.now.beginning_of_day unless starts_at.present?
    self.starts_at = starts_at.change_date(starts_at_date)
  end

  def starts_at_time
    starts_at.to_time.in_time_zone if starts_at.present?
  end

  def starts_at_time=(starts_at_time)
    starts_at_time = Time.zone.parse(starts_at_time) if starts_at_time.is_a? String
    self.starts_at = Time.zone.now.beginning_of_day unless starts_at.present?
    self.starts_at = starts_at.change_time(starts_at_time)
  end

  def ends_at_date
    ends_at.to_date.in_time_zone if ends_at.present?
  end

  def ends_at_date=(ends_at_date)
    ends_at_date = Date.parse(ends_at_date) if ends_at_date.is_a? String
    self.ends_at = Time.zone.now.beginning_of_day unless ends_at.present?
    self.ends_at = ends_at.change_date(ends_at_date)
  end

  def ends_at_time
    ends_at.to_time.in_time_zone if ends_at.present?
  end

  def ends_at_time=(ends_at_time)
    ends_at_time = Time.zone.parse(ends_at_time) if ends_at_time.is_a? String
    self.ends_at = Time.zone.now.beginning_of_day unless ends_at.present?
    self.ends_at = ends_at.change_time(ends_at_time)
  end

end
