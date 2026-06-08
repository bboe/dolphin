# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.4.1'

# Rails framework
gem 'rails', '~> 8.0'

# Drivers / server
gem 'pg'
gem 'puma', '~> 6.0'

# Asset pipeline (Propshaft + Hotwire + Dart Sass)
gem 'dartsass-rails'
gem 'importmap-rails'
gem 'propshaft'
gem 'stimulus-rails'
gem 'turbo-rails'

# Boot speed
gem 'bootsnap', require: false

# Authentication
gem 'devise', '~> 4.9'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'

# Pagination
gem 'will_paginate'

group :development do
  gem 'listen'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'web-console'
end

group :development, :test do
  gem 'debug', platforms: %i[mri windows], require: 'debug/prelude'
end

group :test do
  gem 'minitest-ci'
  gem 'mocha'
end
