source 'http://rubygems.org'

gem 'sinatra'
gem 'activerecord', '~> 4.2', '>= 4.2.6', :require => 'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
gem 'rake'
gem 'require_all'
# gem 'sqlite3', '~> 1.3.6'
# gem 'pg'
gem 'thin'
gem 'shotgun'
gem 'pry'
gem 'bcrypt'
gem 'tux'

group :development, :test do
  gem 'sqlite3', '~> 1.3.6'
end

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'rack-test'
  gem 'database_cleaner-active_record'
end

group :production do
  gem 'pg', '0.15.1'
  gem 'rails_12factor'
end
