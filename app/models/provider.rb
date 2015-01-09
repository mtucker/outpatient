class Provider < User
  validates :name, :email, :phone, :zip_code, presence: true

  belongs_to :specialty

  after_initialize :set_defaults, if: :new_record?

  private

  def set_defaults
    self.is_active = false
  end
end
