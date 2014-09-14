class Provider < User

  validate :name, :email, :phone, :zip_code

end
