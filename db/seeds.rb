# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = Administrator.new
admin.email = 'matt.d.tucker@gmail.com'
admin.name = 'Matt Tucker'
admin.password = 'admin123'
admin.password_confirmation = 'admin123'
admin.save!

admin = Administrator.new
admin.email = 'kunal.x.mehta@gmail.com'
admin.name = 'Kunal Mehta'
admin.password = 'admin123'
admin.password_confirmation = 'admin123'
admin.save!

Specialty.create([
  {name:'Acupuncturist'},
  {name:'Allergist (Immunologist)'},
  {name:'Audiologist'},
  {name:'Cardiologist (Heart Doctor)'},
  {name:'Cardiothoracic Surgeon'},
  {name:'Chiropractor'},
  {name:'Dentist'},
  {name:'Dermatologist'},
  {name:'Dietitian / Nutritionist'},
  {name:'Ear, Nose & Throat Doctor (ENT)'},
  {name:'Endocrinologist (incl Diabetes Specialists)'},
  {name:'Eye Doctor'},
  {name:'Gastroenterologist'},
  {name:'Hearing Specialist'},
  {name:'Hematologist (Blood Specialist)'},
  {name:'Infectious Disease Specialist'},
  {name:'Infertility Specialist'},
  {name:'Midwife'},
  {name:'Naturopathic Doctor'},
  {name:'Nephrologist (Kidney Specialist)'},
  {name:'Neurologist (incl Headache Specialists)'},
  {name:'Neurosurgeon'},
  {name:'OB-GYN (Obstetrician-Gynecologist)'},
  {name:'Oncologist'},
  {name:'Ophthalmologist'},
  {name:'Optometrist'},
  {name:'Orthodontist'},
  {name:'Orthopedic Surgeon (Orthopedist)'},
  {name:'Pain Management Specialist'},
  {name:'Pediatric Dentist'},
  {name:'Pediatrician'},
  {name:'Physiatrist (Physical Medicine)'},
  {name:'Physical Therapist'},
  {name:'Plastic Surgeon'},
  {name:'Podiatrist (Foot and Ankle Specialist)'},
  {name:'Primary Care Doctor'},
  {name:'Prosthodontist'},
  {name:'Psychiatrist'},
  {name:'Psychologist'},
  {name:'Pulmonologist (Lung Doctor)'},
  {name:'Radiologist'},
  {name:'Rheumatologist'},
  {name:'Sleep Medicine Specialist'},
  {name:'Sports Medicine Specialist'},
  {name:'Surgeon'},
  {name:'Therapist / Counselor'},
  {name:'Urgent Care Doctor'},
  {name:'Urological Surgeon'},
  {name:'Urologist'},
  {name:'Vascular Surgeon'}
]);

# TODO Remove this.
100.times do
  FactoryGirl::create(:provider, {specialty: Specialty.offset(rand(Specialty.count)).first})
end
