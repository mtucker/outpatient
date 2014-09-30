# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = Admin.new
admin.email = 'mtucker@chat-md.com'
admin.name = 'Matt Tucker'
admin.password = 'admin123'
admin.password_confirmation = 'admin123'
admin.save!
