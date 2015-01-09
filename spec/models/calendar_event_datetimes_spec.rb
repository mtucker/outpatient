require 'rails_helper'

RSpec.describe CalendarEvent, :type => :model do

  context 'accessing start and end date and times' do

    let(:calendar_event) { 
      FactoryGirl.build(
        :calendar_event, 
        starts_at: '2014-12-17 12:00:00',
        ends_at: '2015-1-19 14:00:00'
      )
    }

    it 'returns correct start date' do
      expect(calendar_event.starts_at_date.in_time_zone.strftime('%m/%d/%Y')).to eq('12/17/2014')
    end

    it 'returns correct start time' do
      expect(calendar_event.starts_at_time.in_time_zone.strftime('%I:%M %p')).to eq('12:00 PM')
    end

    it 'returns correct end date' do
      expect(calendar_event.ends_at_date.strftime('%m/%d/%Y')).to eq('01/19/2015')
    end

    it 'returns correct end time' do
      expect(calendar_event.ends_at_time.strftime('%I:%M %p')).to eq('02:00 PM')
    end

  end

  context 'setting start and end date and times' do

    let(:calendar_event) { 
      FactoryGirl.build(
        :calendar_event, 
        starts_at: '2014-12-17 12:00:00',
        ends_at: '2015-1-19 14:00:00'
      )
    }

    let(:new_calendar_event) { 
      CalendarEvent.new
    }

    it 'updates starts_at when starts_at_date is set with Date' do
      calendar_event.starts_at_date = Date.parse('2015-01-01')
      expect(calendar_event.starts_at.strftime('%m/%d/%Y %I:%M %p')).to eq('01/01/2015 12:00 PM')
    end

    it 'updates starts_at when starts_at_date is set with String' do
      calendar_event.starts_at_date = '2015-01-01'
      expect(calendar_event.starts_at.strftime('%m/%d/%Y %I:%M %p')).to eq('01/01/2015 12:00 PM')
    end

    it 'creates starts_at when starts_at_date is set with Date' do
      new_calendar_event.starts_at_date = Date.parse('2015-01-01')
      expect(new_calendar_event.starts_at_thing.strftime('%m/%d/%Y %I:%M %p')).to eq('01/01/2015 12:00 AM')
    end

    it 'creates starts_at when starts_at_date is set with String' do
      new_calendar_event.starts_at_date = '2015-01-01'
      expect(new_calendar_event.starts_at.strftime('%m/%d/%Y %I:%M %p')).to eq('01/01/2015 12:00 AM')
    end

    it 'updates starts_at when starts_at_time is set with Time' do
      calendar_event.starts_at_time = Time.parse('2:00 PM')
      expect(calendar_event.starts_at.strftime('%m/%d/%Y %I:%M %p')).to eq('12/17/2014 02:00 PM')
    end

    it 'updates starts_at when starts_at_time is set with String' do
      calendar_event.starts_at_time = '2:00 PM'
      expect(calendar_event.starts_at.strftime('%m/%d/%Y %I:%M %p')).to eq('12/17/2014 02:00 PM')
    end

    it 'creates starts_at when starts_at_time is set with Time' do
      new_calendar_event.starts_at_time = Time.parse('2:00 PM')
      expect(new_calendar_event.starts_at.strftime('%I:%M %p')).to eq('02:00 PM')
    end

    it 'creates starts_at when starts_at_time is set with String' do
      new_calendar_event.starts_at_time = '2:00 PM'
      expect(new_calendar_event.starts_at.strftime('%I:%M %p')).to eq('02:00 PM')
    end

    it 'updates ends_at when ends_at_date is set with Date' do 
      calendar_event.ends_at_date = Date.parse('2015-01-01')
      expect(calendar_event.ends_at.strftime('%m/%d/%Y %I:%M %p')).to eq('01/01/2015 02:00 PM')
    end

    it 'updates ends_at when ends_at_date is set with String' do 
      calendar_event.ends_at_date = '2015-01-01'
      expect(calendar_event.ends_at.strftime('%m/%d/%Y %I:%M %p')).to eq('01/01/2015 02:00 PM')
    end

    it 'creates ends_at when ends_at_date is set with Date' do
      new_calendar_event.ends_at_date = Date.parse('2015-01-01')
      expect(new_calendar_event.ends_at.strftime('%m/%d/%Y %I:%M %p')).to eq('01/01/2015 12:00 AM')
    end

    it 'creates ends_at when ends_at_date is set with String' do
      new_calendar_event.ends_at_date = '2015-01-01'
      expect(new_calendar_event.ends_at.strftime('%m/%d/%Y %I:%M %p')).to eq('01/01/2015 12:00 AM')
    end

    it 'updates ends_at when ends_at_time is set with Time' do
      calendar_event.ends_at_time = Time.parse('2:00 PM')
      expect(calendar_event.ends_at.strftime('%m/%d/%Y %I:%M %p')).to eq('01/19/2015 02:00 PM') 
    end

    it 'updates ends_at when ends_at_time is set with String' do
      calendar_event.ends_at_time = '2:00 PM'
      expect(calendar_event.ends_at.strftime('%m/%d/%Y %I:%M %p')).to eq('01/19/2015 02:00 PM') 
    end

    it 'creates ends_at when ends_at_time is set with Time' do
      new_calendar_event.ends_at_time = Time.parse('2:00 PM')
      expect(new_calendar_event.ends_at.strftime('%I:%M %p')).to eq('02:00 PM')
    end

    it 'creates ends_at when ends_at_time is set with String' do
      new_calendar_event.ends_at_time = '2:00 PM'
      expect(new_calendar_event.ends_at.strftime('%I:%M %p')).to eq('02:00 PM')
    end

    it 'persists the start date and time values' do
      calendar_event.starts_at_date = Date.parse('2015-01-01')
      calendar_event.starts_at_time = Time.parse('2:00 PM')
      calendar_event.save
      calendar_event.reload
      expect(calendar_event.starts_at.strftime('%m/%d/%Y %I:%M %p')).to eq('01/01/2015 02:00 PM')
    end

    it 'persists the end date and time values' do
      calendar_event.ends_at_date = Date.parse('2015-01-01')
      calendar_event.ends_at_time = Time.parse('2:00 PM')
      calendar_event.save
      calendar_event.reload
      expect(calendar_event.ends_at.strftime('%m/%d/%Y %I:%M %p')).to eq('01/01/2015 02:00 PM')
    end

  end

end
