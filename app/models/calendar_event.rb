class CalendarEvent < ActiveRecord::Base

  acts_as_paranoid

  validates :starts_at, presence: true, date: true
  validates :ends_at, presence: true, date: {after: :starts_at}
  validates :type, presence: true, inclusion: { in: ['AVAILABLE', 'APPOINTMENT']}

  belongs_to :user

end
