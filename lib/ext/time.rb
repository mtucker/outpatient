class Time

  def change_date(date)
    change(year: date.year, month: date.month, day: date.day)
  end

  def change_time(time)
    change(hour: time.hour, min: time.min, sec: time.sec)
  end

end