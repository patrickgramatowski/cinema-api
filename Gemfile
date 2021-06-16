# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'activerecord-session_store'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.3', '>= 6.1.3.2'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false
# JSON:API rb gem
gem 'jsonapi.rb'
# Background Job
gem 'delayed_job_active_record'
gem 'simplecov', require: false, group: :test

group :development, :test do
  gem 'bundler-audit', '~> 0.8.0'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # Factory bot gem
  gem 'factory_bot_rails'
  # RSpec api doc
  gem 'rspec_api_documentation'
  # RSpec rails
  gem 'rspec-rails', '~> 5.0.0'
  # Use Rubocop gem
  gem 'rubocop', '~> 1.15'
end

group :development do
  gem 'brakeman'
  gem 'dawnscanner', :require => false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem "sidekiq", "~> 6.2"
