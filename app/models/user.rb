class User < ActiveRecord::Base

  acts_as_paranoid

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_update :set_activation_dates, if: :is_active_changed?

  private

  def set_activation_dates

    if(self.is_active)
      self.activated_at = Time.now
    else
      self.deactivated_at = Time.now
    end

  end

end
