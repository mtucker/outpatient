class Time

  @@date_string_format = '%Y/%m/%d'
  @@time_string_format = '%l:%M %p'
  @@datetime_format = '#{@@date_string_format} #{@@time_string_format}'

  def change_date(date)
    change(year: date.year, month: date.month, day: date.day)
  end

  def change_time(time)
    change(hour: time.hour, min: time.min, sec: time.sec)
  end

  def round_down_to_nearest_half_hour
    min >= 30 ? change(min: 30) : change(min: 0)
  end

  def to_formatted_date
    strftime(@@date_string_format)
  end

  def to_formatted_time
    strftime(@@time_string_format).lstrip
  end

  def to_formatted_datetime
    strftime(@@datetime_format)
  end

end
