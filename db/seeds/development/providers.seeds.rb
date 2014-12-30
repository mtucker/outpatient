Provider.find_or_create_by(email: 'provider@outpatient.co') do |provider|
  provider.email = 'provider@outpatient.co'
  provider.name = 'John Provider'
  provider.password = 'provider123'
  provider.password_confirmation = 'provider123'
  provider.phone = Faker::PhoneNumber.phone_number
  provider.zip_code = Faker::Address.zip
  provider.specialty = Specialty.offset(rand(Specialty.count)).first
end

# TODO Remove this.
100.times do
  FactoryGirl::create(:provider,
    {
      specialty: Specialty.offset(rand(Specialty.count)).first,
      is_active: rand(0..1)
    }
  )
end