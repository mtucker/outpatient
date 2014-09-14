class Provider < User

  validates :name, :email, :phone, :zip_code, presence: true

end
