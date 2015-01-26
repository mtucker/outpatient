class Appointment < ActiveRecord::Base
  belongs_to :calendar_event
  belongs_to :provider
  belongs_to :user
end
