source 'https://rubygems.org'
ruby '2.1.5'

gem 'inherited_resources',
    github: 'josevalim/inherited_resources',
    branch: 'rails-4-2'
gem 'activeadmin', github: 'activeadmin'
gem 'bitters'
gem 'bourbon'
gem 'coffee-rails'
gem 'sass-rails'
gem 'sass'
gem 'compass-rails'
gem 'date_validator'
gem 'devise'
gem 'faker'
gem 'factory_girl_rails'
gem 'fullcalendar-rails'
gem 'jquery-rails'
gem 'momentjs-rails'
gem 'neat'
gem 'paranoia', '~> 2.0'
gem 'pg'
gem 'rails'
gem 'refills'
gem 'responders', '~> 2.0'
gem 'seedbank'
gem 'simple_calendar', '~> 1.1.0'
gem 'simple_form'
gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'

group :production do
  gem 'rails_12factor'
end

group :development do
  gem 'awesome_print'
  gem 'guard-livereload', require: false
  gem 'guard-rspec',      require: false
  gem 'guard-sass',       require: false
  gem 'guard-compass',    require: false
  gem 'meta_request'
  gem 'rubocop',          require: false
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-stack_explorer'
  gem 'rspec-rails'
end

group :test, :darwin do
  gem 'rb-fsevent'
end

group :test do
  gem 'database_cleaner'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'launchy'
end
