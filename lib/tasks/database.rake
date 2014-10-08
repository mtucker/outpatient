namespace :db do
  desc 'Truncate all tables'
  task :truncate => :environment do
    conn = ActiveRecord::Base.connection
    tables = conn.tables;
    tables.delete 'schema_migrations'
    tables.each { |t| conn.execute("TRUNCATE #{t}") }
  end
end

namespace :db do
  desc 'Truncate and reseed all tables'
  task :reseed => :environment do
    Rake::Task['db:truncate'].invoke
    Rake::Task['db:seed'].invoke
  end
end
