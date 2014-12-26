provider = Provider.new
provider.email = 'provider@outpatient.co'
provider.name = 'John Provider'
provider.password = 'provider123'
provider.password_confirmation = 'provider123'
provider.phone = Faker::PhoneNumber.phone_number
provider.zip_code = Faker::Address.zip
provider.specialty = Specialty.offset(rand(Specialty.count)).first
provider.save!

# TODO Remove this.
100.times do
  FactoryGirl::create(:provider,
    {
      specialty: Specialty.offset(rand(Specialty.count)).first,
      is_active: rand(0..1)
    }
  )
end