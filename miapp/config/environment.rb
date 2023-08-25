# config/environment.rb
db_options = YAML.load(File.read('./config/database.yml'), aliases: true)

environment = ENV['APP_ENV'] || 'development'
ActiveRecord::Base.establish_connection(db_options[environment])