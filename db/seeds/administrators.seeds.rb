Administrator.find_or_create_by(email: 'matt@outpatient.co') do |admin|
  admin.email = 'matt.d.tucker@gmail.com'
  admin.name = 'Matt Tucker'
  admin.password = 'admin123'
  admin.password_confirmation = 'admin123'
end

Administrator.find_or_create_by(email: 'kunal@outpatient.co') do |admin|
  admin.email = 'kunal.x.mehta@gmail.com'
  admin.name = 'Kunal Mehta'
  admin.password = 'admin123'
  admin.password_confirmation = 'admin123'
end