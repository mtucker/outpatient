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

  def round_up_to_nearest_half_hour
    min <= 30 ? change(min: 30) : change(hour: hour + 1, min: 0)
  end  
  
  def round_to_nearest_half_hour
    if(min <= 15) 
      change(min: 0)
    elsif(15 < min && min < 45)
      change(min: 30)
    elsif(min >= 45)
      change(min: 0)
      change(hour: hour + 1)
    end   
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

  def self.parse_date_and_time(date_string, time_string)
    date = Date.parse(date_string)
    time = Time.parse(time_string)
    Time.new(date.year, date.month, date.day, time.hour, time.min, time.sec)
  end

end
