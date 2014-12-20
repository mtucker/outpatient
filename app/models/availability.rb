class Availability < CalendarEvent

  scope :user, -> (user) { where("user_id = ?", "#{user.id}")}
  scope :starts_after, -> (start_dttm) { where("starts_at >= ?", "#{start_dttm}")}
  scope :starts_before, -> (end_dttm) { where("starts_at <= ?", "#{end_dttm}")}

end